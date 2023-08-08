import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        SimpleDependency.configure()
        SwinjectDependency.configure()
        SwiftLeeDependency.configure()
        CustomLeeDependency.configure()
        ExtensionDependency.configure()

        registerProviderFactories() // For Needle

        return true
    }
}
