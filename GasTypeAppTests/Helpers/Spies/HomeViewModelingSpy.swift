//
//  HomeViewModelingSpy.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

@testable import GasTypeApp
final class HomeViewModelingSpy: HomeViewModeling {
    enum Message: Hashable {
        case openGasTypeView
    }

    private(set) var messages = [Message]()

    func openGasTypeView() {
        messages.append(.openGasTypeView)
    }
}
