import SwiftUI

struct ContentView: View {
    @State var bastardText: String = ""
    @State var simpleText: String = ""
    @State var swinjectText: String = ""
    @State var extensionText: String = ""
    @State var needleText: String = ""
    @State var leeText: String = ""
    @State var customLeeText: String = ""

    let bastardUseCase: FooUseCase = BastardUseCase()

    let simpleUseCase: FooUseCase = SimpleContainer.shared.fooUseCase

    let swinjectUseCase: FooUseCase = SwinjectContainer.resolve(FooUseCase.self)

    @SwiftLeeInject(\.fooUseCase) var leeUseCase: FooUseCase

    @CustomLeeInject(\.fooUseCase) var customLeeUseCase: FooUseCase

    let extensionUseCase: FooUseCase = ExtensionUseCase()

    let needleUseCase: FooUseCase = NeedleComponent().fooUseCase

    var body: some View {
        VStack {
            HStack {
                Button("Bastard") {
                    bastardText = bastardUseCase.fetch()
                }
                Spacer()
                Text(bastardText)
            }
            HStack {
                Button("Simple") {
                    simpleText = simpleUseCase.fetch()
                }
                Spacer()
                Text(simpleText)
            }
            HStack {
                Button("Swinject") {
                    swinjectText = swinjectUseCase.fetch()
                }
                Spacer()
                Text(swinjectText)
            }
            HStack {
                Button("Lee") {
                    leeText = leeUseCase.fetch()
                }
                Spacer()
                Text(leeText)
            }
            HStack {
                Button("Custom Lee") {
                    customLeeText = customLeeUseCase.fetch()
                }
                Spacer()
                Text(customLeeText)
            }
            HStack {
                Button("Extension") {
                    extensionText = extensionUseCase.fetch()
                }
                Spacer()
                Text(extensionText)
            }
            HStack {
                Button("Needle") {
                    needleText = needleUseCase.fetch()
                }
                Spacer()
                Text(needleText)
            }

        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
