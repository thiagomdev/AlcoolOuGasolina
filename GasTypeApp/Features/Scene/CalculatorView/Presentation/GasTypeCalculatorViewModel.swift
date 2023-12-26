import Foundation

protocol GasTypeCalculatorViewModeling {
    func backToHome()
    func calculatePrice(from ethanol: String, _ gas: String)
    func validateEmptyField(from ethanol: String, _ gas: String) -> Bool
    var showAlert: (() -> Void)? { get set }
}

final class GasTypeCalculatorViewModel {
    private var coordinator: GasTypeCalculatorCoordinating
    var showAlert: (() -> Void)?
    
    init(
        coordinator: GasTypeCalculatorCoordinating
    ) {
        self.coordinator = coordinator
    }
}

extension GasTypeCalculatorViewModel: GasTypeCalculatorViewModeling {
    func backToHome() {
        coordinator.backToHome()
    }
    
    func calculatePrice(from ethanol: String, _ gas: String) {
        if validateEmptyField(from: ethanol, gas) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            
            let ethanolPrice: Double = formatter.number(from: ethanol) as? Double ?? .zero
            let gasPrice: Double = formatter.number(from: gas) as? Double ?? .zero

            if ethanolPrice / gasPrice > 0.7 {
                coordinator.displayCalculatedPrice(from: .gas)
            } else {
                coordinator.displayCalculatedPrice(from: .ethanol)
            }
        }
    }
    
    func validateEmptyField(from ethanol: String, _ gas: String) -> Bool {
        if ethanol.isEmpty || gas.isEmpty {
            showAlert?()
            return false
        }
        return true
    }
}

enum GasType: String {
    case ethanol = "ÀLCOOL"
    case gas = "GASOLINA"
}
