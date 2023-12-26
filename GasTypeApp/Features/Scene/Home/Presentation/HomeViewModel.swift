import Foundation
 
protocol HomeViewModeling {
    func openGasTypeView()
}

final class HomeViewModel {
    private var coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomeViewModel: HomeViewModeling {
    func openGasTypeView() {
        coordinator.openGasTypeView()
    }
}
