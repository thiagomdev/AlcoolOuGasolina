//
//  CalculatedCoordinatingSpy.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

@testable import GasTypeApp
final class CalculatedCoordinatingSpy: CalculatedCoordinating {
    enum Message: Hashable {
        case start(gasType: GasType)
        case calculatePriceAgain
    }

    private(set) var messages = [Message]()

    func start(from gasType: GasType) {
        messages.append(.start(gasType: gasType))
    }

    func calculatePriceAgain() {
        messages.append(.calculatePriceAgain)
    }
}
