//
//  HomeViewModelTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import XCTest
@testable import GasTypeApp

final class HomeViewModelTests: XCTestCase {
    func test_() {
        let (sut, homeCoordinatingSpy) = makeSut()
        
        sut.openGasTypeView()
        
        XCTAssertEqual(homeCoordinatingSpy.messages, [.openGasTypeView])
    }
}

extension HomeViewModelTests {
    private func makeSut() -> (sut: HomeViewModel, homeCoordinating: HomeCoordinatingSpy) {
        let homeCoordinatingSpy = HomeCoordinatingSpy()
        let sut = HomeViewModel(coordinator: homeCoordinatingSpy)
        return (sut, homeCoordinatingSpy)
    }
}

final class HomeCoordinatingSpy: HomeCoordinating {
    enum Message {
        case start
        case openGasTypeView
    }
    
    private(set) var messages = Set<Message>()
    
    func start() {
        messages.insert(.start)
    }
    
    func openGasTypeView() {
        messages.insert(.openGasTypeView)
    }
}
