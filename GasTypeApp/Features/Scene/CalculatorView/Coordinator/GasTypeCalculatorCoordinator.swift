import UIKit

protocol GasTypeCalculatorCoordinating: AnyObject {
    func start()
    func backToHome()
    func displayCalculatedPrice(from gasType: GasType)
}

final class GasTypeCalculatorCoordinator {

    private let window: UIWindow
    private var navigation: UINavigationController
    private var root: UIViewController?
    private var homeCoordinator: HomeCoordinating?
    private var calculatedCoordinator: CalculatedCoordinating?
    
    init(
        window: UIWindow,
        navigation: UINavigationController,
        calculatedCoordinator: CalculatedCoordinating
    ) {
        self.window = window
        self.navigation = navigation
        self.calculatedCoordinator = calculatedCoordinator
    }
}

extension GasTypeCalculatorCoordinator: GasTypeCalculatorCoordinating {
    func start() {
        let viewModel = GasTypeCalculatorViewModel(coordinator: self)
        let gasTypeViewController = GasTypeCalculatorViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: gasTypeViewController)

        UIView.transition(
            with: window,
            duration: 0.6,
            options: .transitionCrossDissolve,
            animations: { [weak self] in
            guard let self else { return }
                
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        })
    }
    
    func backToHome() {
        homeCoordinator = HomeCoordinator(
            window: window,
            navigation: navigation,
            gasTypeCoordinator: self
        )
        homeCoordinator?.start()
    }
    
    func displayCalculatedPrice(from gasType: GasType) {
        calculatedCoordinator = CalculatedCoordinator(
            window: window,
            navigation: navigation
        )
        calculatedCoordinator?.start(from: gasType)
    }
}
