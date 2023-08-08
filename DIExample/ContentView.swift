import SwiftUI

struct ContentView: View {
    @State var bastardText: String = "Hello, world!"
    @State var swinjectText: String = "Hello, world!"
    @State var pwText: String = "Hello, world!"

    let bastardUseCase: FooUseCase = BastardUseCase()

    let swinjectUseCase: FooUseCase = SwinjectContainer.resolve(FooUseCase.self)

    let propertyWrapperUseCase: FooUseCase = PWUseCase()

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
                Button("Swinject") {
                    swinjectText = swinjectUseCase.fetch()
                }
                Spacer()
                Text(swinjectText)
            }
            HStack {
                Button("Property Wrapper") {
                    pwText = propertyWrapperUseCase.fetch()
                }
                Spacer()
                Text(pwText)
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
