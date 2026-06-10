import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let window = UIWindow(windowScene: windowScene)
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
    }
}
