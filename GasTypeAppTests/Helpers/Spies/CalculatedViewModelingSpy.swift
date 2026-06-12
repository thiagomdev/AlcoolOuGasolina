//
//  CalculatedViewModelingSpy.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

@testable import GasTypeApp
final class CalculatedViewModelingSpy: CalculatedViewModeling {
    enum Message: Hashable {
        case calculatePrice
    }

    private(set) var messages = [Message]()

    func calculatePrice() {
        messages.append(.calculatePrice)
    }
}
