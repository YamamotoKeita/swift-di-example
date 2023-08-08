import SwiftUI

@main
struct DIExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    SwinjectContainer.initialize()
                }
        }
    }
}
