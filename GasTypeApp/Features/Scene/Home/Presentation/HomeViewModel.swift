import Foundation
 
protocol HomeViewModeling {
    func openGasTypeView()
}

final class HomeViewModel {
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomeViewModel: HomeViewModeling {
    func openGasTypeView() {
        coordinator.openGasTypeView()
    }
}
