import Foundation

protocol CalculatedViewModeling {
    func calculatePrice()
}

final class CalculatedViewModel {
    private var coordinator: CalculatedCoordinating
    
    init(
        coordinator: CalculatedCoordinating
    ) {
        self.coordinator = coordinator
    }
}

extension CalculatedViewModel: CalculatedViewModeling {
    func calculatePrice() {
        coordinator.calculatePriceAgain()
    }
}
