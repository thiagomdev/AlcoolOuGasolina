//
//  GasTypeCalculatorViewModelTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import XCTest
@testable import GasTypeApp

final class GasTypeCalculatorViewModelTests: XCTestCase {
    func test_backToHome() {
        let (sut, spy) = makeSut()
        
        sut.backToHome()
        
        XCTAssertEqual(spy.messages, [.backToHome])
    }
    
    func test_calculatePrice_whenRatioIsGreaterThanThreshold_displaysGas() {
        let (sut, spy) = makeSut()

        sut.calculatePrice(from: "8", "10")

        XCTAssertEqual(spy.messages, [.displayCalculatedPrice(gasType: .gas)])
    }

    func test_calculatePrice_whenRatioIsLowerThanThreshold_displaysEthanol() {
        let (sut, spy) = makeSut()

        sut.calculatePrice(from: "5", "10")

        XCTAssertEqual(spy.messages, [.displayCalculatedPrice(gasType: .ethanol)])
    }

    func test_calculatePrice_whenRatioEqualsThreshold_displaysEthanol() {
        let (sut, spy) = makeSut()

        sut.calculatePrice(from: "7", "10")

        XCTAssertEqual(spy.messages, [.displayCalculatedPrice(gasType: .ethanol)])
    }

    func test_calculatePrice_whenFieldsAreEmpty_showsAlertAndDoesNotDisplayPrice() {
        let (sut, spy) = makeSut()
        var alertCallCount = 0
        sut.showAlert = { alertCallCount += 1 }

        sut.calculatePrice(from: "", "")

        XCTAssertEqual(alertCallCount, 1)
        XCTAssertEqual(spy.messages, [])
    }
}

extension GasTypeCalculatorViewModelTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: GasTypeCalculatorViewModel, spy: GasTypeCalculatorCoordinatingSpy) {
        let spy = GasTypeCalculatorCoordinatingSpy()
        let sut = GasTypeCalculatorViewModel(coordinator: spy)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(spy, file: file, line: line)
        
        return (sut, spy)
    }
}
