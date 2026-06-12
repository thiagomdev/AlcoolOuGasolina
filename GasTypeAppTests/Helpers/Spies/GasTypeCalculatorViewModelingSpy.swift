//
//  GasTypeCalculatorViewModelingSpy.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

@testable import GasTypeApp
final class GasTypeCalculatorViewModelingSpy: GasTypeCalculatorViewModeling {
    enum Message: Hashable {
        case backToHome
        case calculatePrice(ethanol: String, gas: String)
        case validateEmptyField(ethanol: String, gas: String)
    }

    private(set) var messages = [Message]()
    var showAlert: (() -> Void)?
    var validateResult = true

    func backToHome() {
        messages.append(.backToHome)
    }

    func calculatePrice(from ethanol: String, _ gas: String) {
        messages.append(.calculatePrice(ethanol: ethanol, gas: gas))
    }

    func validateEmptyField(from ethanol: String, _ gas: String) -> Bool {
        messages.append(.validateEmptyField(ethanol: ethanol, gas: gas))
        return validateResult
    }
}
