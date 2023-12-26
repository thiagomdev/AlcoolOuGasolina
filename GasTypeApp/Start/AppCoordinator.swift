import UIKit

protocol AppCoordinating {
    func start()
    func displayCalculatorView()
    func displayCalculatedPriceView(from gasType: GasType)
}

final class AppCoordinator {
    
    var window: UIWindow
    var navigation: UINavigationController
    var viewController: UIViewController?
    let homeCoordinator: HomeCoordinator
    let gasTypeCoordinator: GasTypeCalculatorCoordinator
    let calculatedCoordinator: CalculatedCoordinator
    
    init(
        window: UIWindow,
        navigation: UINavigationController,
        homeCoordinator: HomeCoordinator,
        gasTypeCoordinator: GasTypeCalculatorCoordinator,
        calculatedCoordinator: CalculatedCoordinator
        
    ) {
        self.window = window
        self.navigation = navigation
        self.homeCoordinator = homeCoordinator
        self.gasTypeCoordinator = gasTypeCoordinator
        self.calculatedCoordinator = calculatedCoordinator
    }
}

extension AppCoordinator: AppCoordinating {
    func start() {
        homeCoordinator.start()
    }
    
    func displayCalculatorView() {
        gasTypeCoordinator.start()
    }
    
    func displayCalculatedPriceView(from gasType: GasType) {
        calculatedCoordinator.start(from: gasType)
    }
}
