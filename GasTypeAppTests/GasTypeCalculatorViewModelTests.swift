import Testing
@testable import GasTypeApp

@Suite("GasTypeCalculatorViewModel")
struct GasTypeCalculatorViewModelTests {
    
    @Test("Prefere gasolina quando a razão é maior que 0.7")
    func calculatesGasPreference() {
        let coordinator = CoordinatorSpy()
        let sut = GasTypeCalculatorViewModel(coordinator: coordinator)
        
        sut.calculatePrice(from: "5.00", "7.00")
        
        #expect(coordinator.displayedGasType == .gas)
    }
    
    @Test("Prefere etanol quando a razão é igual ou menor que 0.7")
    func calculatesEthanolPreference() {
        let coordinator = CoordinatorSpy()
        let sut = GasTypeCalculatorViewModel(coordinator: coordinator)
        
        sut.calculatePrice(from: "4.00", "6.00")
        
        #expect(coordinator.displayedGasType == .ethanol)
    }
    
    @Test("Dispara alerta quando existe campo vazio")
    func alertsWhenFieldsAreEmpty() {
        let coordinator = CoordinatorSpy()
        let sut = GasTypeCalculatorViewModel(coordinator: coordinator)
        var presentedAlert = false
        sut.showAlert = { presentedAlert = true }
        
        sut.calculatePrice(from: "", "6.00")
        
        #expect(presentedAlert)
        #expect(coordinator.displayedGasType == nil)
    }
}

private final class CoordinatorSpy: GasTypeCalculatorCoordinating {
    private(set) var displayedGasType: GasType?
    
    func start() {}
    
    func backToHome() {}
    
    func displayCalculatedPrice(from gasType: GasType) {
        displayedGasType = gasType
    }
}
