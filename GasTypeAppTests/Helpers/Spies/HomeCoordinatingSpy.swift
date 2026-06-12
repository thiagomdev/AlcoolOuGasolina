//
//  HomeCoordinatingSpy.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

@testable import GasTypeApp
final class HomeCoordinatingSpy: HomeCoordinating {
    enum Message {
        case start
        case openGasTypeView
    }
    
    private(set) var messages = [Message]()
    
    func start() {
        messages.append(.start)
    }
    
    func openGasTypeView() {
        messages.append(.openGasTypeView)
    }
}
