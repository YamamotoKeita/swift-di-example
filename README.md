# SwiftのDIコンテナは何がいいか？（DI方法7種まとめ）

# まとめ

- SwiftのDIコンテナに今のところ決定的なものはない
- 厳密にはDIというか、Service Locatorパターンになる
- ライブラリを使う場合、ほぼSwinject一択
- Swinjectもそれ程強力ではないので、長い目で見れば自作が一番良さそう



# 概要

ライブラリ含めて、色々なSwiftのDIコンテナを使って、サンプル実装をした。

## 試したもの

1. バスタードインジェクション
2. 簡単な自作DIコンテナ
3. SwiftLeeのDI
4. PropertyWrapperを使った独自DI
5. Extensionを使ったDI
6. Swinject ライブラリ
7. Needle ライブラリ

## 試さなかったもの

- 型パラメーターインジェクション (機能的に不十分なため)
- DITranquillity ライブラリ (Starが少なすぎるため)
- Dip ライブラリ (Starが少なすぎるため)
- Cleanse ライブラリ (3年間更新されていないため)


## 前提条件

いずれのDI方法でも共通的に、`FooUseCase` と `FooRepository` の2つについて、プロダクション実装とテスト向けのモック実装をインジェクションする。

```swift
protocol FooRepository {
    func fetchData() -> String
}
```

```swift
protocol FooUseCase {
    func fetch() -> String
}
```

# サンプルコード

本Repositoryでは各DI手法についてそれぞれ、プロダクションコードを想定したインジェクションと、MockRepositoryをインジェクトするテストコードを実装している。


# 各DIの詳細

## 1.バスタードインジェクション

コンポーネントのイニシャライザの引数で依存モジュールを受け取る形にし、そのデフォルト引数にプロダクションの依存コンポーネントを設定する。
テストのときはテスト用のモックなどをイニシャライザの引数に渡してコンポーネントを生成する。

```swift
class BastardUseCase: FooUseCase {
    private let fooRepository: FooRepository

    init(fooRepository: FooRepository = FooRepositoryImpl()) {
        self.fooRepository = fooRepository
    }
}
```

```swift
final class BastardTests: XCTestCase {
    func testUseCase() throws {
        let useCase = BastardUseCase(fooRepository: FooRepositoryMock())
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
```

この方法はとても簡単に、プロダクション用モジュールとテスト用モックモジュールなどの切り替えができるが、**コンテナがないため共有オブジェクトを管理できない**。
（※共有オブジェクト＝差し替え可能なシングルトンのようなもの）

また、デフォルト引数でモジュールの実装(FooRepositoryImpl)を参照するため、ドメインロジックから実装への依存ができてしまい、**依存性逆転の原則を満たせない。**

## 2.簡単な自作DIコンテナ

モジュールを格納するためのコンテナを作り、共有オブジェクトとして保持しておく。

```swift
struct SimpleContainer {
    static var shared: SimpleContainer!

    var fooRepository: FooRepository
    var fooUseCase: FooUseCase
}
```

アプリケーションの起動時などに、コンテナの中に必要なモジュールを格納する。

```swift
enum SimpleDependency {
    static func configure() {
        let fooRepository = FooRepositoryImpl()
        let fooUseCase = SimpleUseCase(fooRepository: fooRepository)

        SimpleContainer.shared = SimpleContainer(
            fooRepository: fooRepository,
            fooUseCase: fooUseCase
        )
    }
}
```

各モジュールを使うときは、共有オブジェクトのコンテナから取り出して使う。

```swift
let fooUseCase = SimpleContainer.shared.fooUseCase
```

## 3.SwiftLeeのDI

以下の記事で紹介されたDIのやり方。

https://www.avanderlee.com/swift/dependency-injection/

基本のアイデアは、以下のように独自の`PropertyWrapper`を使って、共有オブジェクトのコンポーネントをメンバー変数で使えるようにする。

```swift
class SwiftLeeUseCase: FooUseCase {
    @Inject(\.fooRepository) var fooRepository: FooRepository
}
```

PropertyWrapper `@Inject` の実装は以下のようになっており、`wrappedValue`のgetとsetで、SwiftLeeContainerが管理するコンポーネントにアクセスできるようになっている。


```swift
@propertyWrapper
struct Inject<T> {

    private let keyPath: WritableKeyPath<SwiftLeeContainer, T>

    var wrappedValue: T {
        get { SwiftLeeContainer[keyPath] }
        set { SwiftLeeContainer[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<SwiftLeeContainer, T>) {
        self.keyPath = keyPath
    }
}
```

以下がコンテナの実装。

コンテナにそのままコンポーネントを格納するのではなく、
コンポーネント毎に共有オブジェクトを格納するための構造体（以下の例では、FooRepositoryStoreとFooUseCaseStore）を作って、そこにコンポーネントを格納している。


```swift
struct SwiftLeeContainer {
    private static var current = SwiftLeeContainer()

    static subscript<T>(_ keyPath: WritableKeyPath<SwiftLeeContainer, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }

    var fooRepository: FooRepository {
        get { FooRepositoryStore.currentValue }
        set { FooRepositoryStore.currentValue = newValue }
    }

    var fooUseCase: FooUseCase {
        get { FooUseCaseStore.currentValue }
        set { FooUseCaseStore.currentValue = newValue }
    }
}

protocol ValueStore {
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

struct FooRepositoryStore: ValueStore {
    static var currentValue: FooRepository = FooRepositoryImpl()
}

struct FooUseCaseStore: ValueStore {
    static var currentValue: FooUseCase = SwiftLeeUseCase()
}

```

ただ、この方法もバスタードインジェクションと同じく、DIの核となる部分でモジュールの実装(FooRepositoryImplとSwiftLeeUseCase)を参照してしまっており、**依存性逆転の原則を満たしていない。**

この問題を解消するには、コンポーネントを格納する変数をオプショナルにしてやり、初期値のセットをやめれば良い。

```swift
struct FooRepositoryStore: ValueStore {
    static var currentValue: FooRepository?
}
```

## 4.PropertyWrapperを使った独自DI

SwiftLeeのPropertyWrapperのアイデアを使って、**依存性逆転の原則を満たすよう改良**した独自のDI実装。

実装をシンプルにするため、SwiftLeeの実装にあった`ValueStore`はやめて、代わりに各種コンポーネントを格納するコンテナを共有オブジェクトの形で持つ。

```swift
class CustomLeeContainer {
    static var shared = CustomLeeContainer()

    var fooRepository: FooRepository?
    var fooUseCase: FooUseCase?
}
```
PropertyWrapperではこの共有オブジェクトのコンテナから各種コンポーネントを取り出す。

```swift
@propertyWrapper
struct Inject<T> {

    private let keyPath: WritableKeyPath<CustomLeeContainer, T?>

    var wrappedValue: T {
        get { CustomLeeContainer.shared[keyPath: keyPath]! }
        set { CustomLeeContainer.shared[keyPath: keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<CustomLeeContainer, T?>) {
        self.keyPath = keyPath
    }
}
```

## 5.Extensionを使ったDI

コンテナ部分は「簡単な自作DIコンテナ」と同じだが、以下のようなprotocolとextensionを使って、コンポーネントを使うこともできる。

```swift
protocol UsesFooRepository {
    var fooRepository: FooRepository { get }
}
extension UsesFooRepository {
    var fooRepository: FooRepository { ExtensionContainer.shared.fooRepository }
}
```

`fooRepository` を使いたいコンポーネントは、クラスに`UsesFooRepository`をつければ、`extension UsesFooRepository` を経由して、共有オブジェクトのコンポーネントを使えるようになる。

```swift
class ExtensionUseCase: FooUseCase, UsesFooRepository {
    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
```

## 6.Swinject (GitHub ★5.9k)

https://github.com/Swinject/Swinject

おそらくSwiftのDI系ライブラリの中で一番有名。

`Container`クラスのオブジェクトに、型と紐付けて特定のオブジェクトを登録していく仕組み


```swift
let container = Container()
container.register(FooRepository.self) { _ in FooRepositoryImpl() }
container.register(FooUseCase.self) { r in
    SwinjectUseCase(fooRepository: r.resolve(FooRepository.self)!)
}
```

コンポーネントを使うときは以下のように型を指定して、コンテナからコンポーネントを取り出す。

```swift
let useCase = container.resolve(FooUseCase.self)
```

基本的には `Container` クラスのオブジェクトをグローバル変数や共有オブジェクトにして使う想定と思われる。


## 7.Needle (GitHub ★1.9k)

https://github.com/uber/needle

今回試したDI手法の中で、唯一Service Locatorパターンではなく、ちゃんとしたDIをしている。

しかし、以下のようにネガティブなポイントがたくさんあり、プロダクションに採用するのはナシかな、という印象。

- コード生成が必要
-  コード生成にCLIのインストールが別途必要
- バージョンまだ0.23.0だが、更新があまり活発ではない
- 全てのコンポーネントはNeedleの`Component`クラスを継承しなければならず、Needleへの依存が強くなりすぎる。

### Needleの使い方

Needleを使うにはまず、`BootstrapComponent` クラスを継承したRootComponentを作る必要がある。
RootComponentは全てのコンポーネントの親になり、ここで依存する具体的なコンポーネントを決める。

```swift
class NeedleComponent: BootstrapComponent {
    var fooRepository: FooRepository {
        shared { FooRepositoryImpl() }
    }

    var fooUseCase: FooUseCase {
        shared { NeedleUseCase(parent: self) }
    }
}
```

各コンポーネントには親コンポーネントから依存するコンポーネントが渡され、それをComponentクラスの `dependency` プロパティから取得することができる。

```swift
final class NeedleUseCase: Component<NeedleDependency>, FooUseCase {

    var fooRepository: FooRepository { dependency.fooRepository }

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
```

### Needleのセットアップ

Needleを使う場合、コード生成のためのCLIをインストールし、アプリのBuild PhasesにCLIを実行するスクリプトを追加する必要がある。
詳細については、Needleのドキュメントを参照。

## 試さなかった方法

### 型パラメーターインジェクション

以下の記事のような方法も紹介されていたが、コンポーネントがstatic関数しか使えなくなるという縛りが実用的でないと思われたので、試していない。

https://qiita.com/uhooi/items/16aa67b44e2614c8d7b9


### その他のライブラリ

以下のライブラリは、Starが少ないか、更新が長期間止まっており、プロダクションには採用できないと判断したため試していない。

- DITranquillity - Starが少ない
- Dip - Starが少ない
- Cleanse - 3年間更新されていない