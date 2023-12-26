import UIKit

protocol CalculatedCoordinating {
    func start(from gasType: GasType)
    func calculatePriceAgain()
}

final class CalculatedCoordinator {
    private let window: UIWindow
    private var navigation: UINavigationController
    private var coordinator: GasTypeCalculatorCoordinating?
    
    init(
        window: UIWindow,
        navigation: UINavigationController
    ) {
        self.window = window
        self.navigation = navigation
    }
}

extension CalculatedCoordinator: CalculatedCoordinating {
    func start(from gasType: GasType) {
        let viewModel = CalculatedViewModel(coordinator: self)
        let calculatedViewController = CalculatedViewController(viewModel: viewModel)
        calculatedViewController.calculatedPriceLabel.text = gasType.rawValue
        let navigation = UINavigationController(rootViewController: calculatedViewController)

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
    
    func calculatePriceAgain() {
        coordinator = GasTypeCalculatorCoordinator(
            window: window,
            navigation: navigation,
            calculatedCoordinator: self
        )
        coordinator?.start()
    }
}
