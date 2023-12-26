import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable.toggle()
        let window = UIWindow(frame: UIScreen.main.coordinateSpace.bounds)
        self.window = window
        
        let navigation = UINavigationController()

        let calculatedCoordinator = CalculatedCoordinator(
            window: window,
            navigation: navigation
        )
        
        let gasTypeCoordinator = GasTypeCalculatorCoordinator(
            window: window,
            navigation: navigation,
            calculatedCoordinator: calculatedCoordinator
        )
        
        let homeCoordinator = HomeCoordinator(
            window: window,
            navigation: navigation,
            gasTypeCoordinator: gasTypeCoordinator
        )
        
        appCoordinator = AppCoordinator(
            window: window,
            navigation: navigation,
            homeCoordinator: homeCoordinator,
            gasTypeCoordinator: gasTypeCoordinator,
            calculatedCoordinator: calculatedCoordinator
        )
        
        appCoordinator?.start()
        return true
    }
}
