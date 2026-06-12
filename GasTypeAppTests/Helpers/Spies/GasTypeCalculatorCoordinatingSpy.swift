//
//  GasTypeCalculatorCoordinatingSpy.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

@testable import GasTypeApp
final class GasTypeCalculatorCoordinatingSpy: GasTypeCalculatorCoordinating {
    enum Message: Hashable {
        case start
        case backToHome
        case displayCalculatedPrice(gasType: GasType)
    }
    
    private(set) var messages = [Message]()
    
    func start() {
        messages.append(.start)
    }
    
    func backToHome() {
        messages.append(.backToHome)
    }
    
    func displayCalculatedPrice(from gasType: GasType) {
        messages.append(.displayCalculatedPrice(gasType: gasType))
    }
}
