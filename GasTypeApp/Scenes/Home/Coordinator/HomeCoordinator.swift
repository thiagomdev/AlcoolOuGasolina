import UIKit

protocol HomeCoordinating: AnyObject {
    func start()
    func openGasTypeView()
}

final class HomeCoordinator {
    private let window: UIWindow
    private var navigation: UINavigationController
    private var root: UIViewController?
    weak var gasTypeCoordinator: GasTypeCalculatorCoordinating?
    
    init(
        window: UIWindow,
        navigation: UINavigationController,
        gasTypeCoordinator: GasTypeCalculatorCoordinating
    ) {
        self.window = window
        self.navigation = navigation
        self.gasTypeCoordinator = gasTypeCoordinator
    }
}

extension HomeCoordinator: HomeCoordinating {
    func start() {
        let viewModel = HomeViewModel(coordinator: self)
        let home = HomeViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: home)

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
    
    func openGasTypeView() {
        gasTypeCoordinator?.start()
    }
}
