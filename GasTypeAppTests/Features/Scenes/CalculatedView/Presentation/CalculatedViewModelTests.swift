//
//  CalculatedViewModelTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import XCTest
@testable import GasTypeApp

final class CalculatedViewModelTests: XCTestCase {
    func test_calculatePrice_shouldAskCoordinatorToCalculatePriceAgain() {
        let (sut, spy) = makeSut()

        sut.calculatePrice()

        XCTAssertEqual(spy.messages, [.calculatePriceAgain])
    }

    func test_calculatePrice_whenCalledTwice_forwardsEachCallToCoordinator() {
        let (sut, spy) = makeSut()

        sut.calculatePrice()
        sut.calculatePrice()

        XCTAssertEqual(spy.messages, [.calculatePriceAgain, .calculatePriceAgain])
    }

    func test_init_doesNotMessageCoordinator() {
        let (_, spy) = makeSut()

        XCTAssertEqual(spy.messages, [])
    }
}

extension CalculatedViewModelTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: CalculatedViewModel, spy: CalculatedCoordinatingSpy) {
        let spy = CalculatedCoordinatingSpy()
        let sut = CalculatedViewModel(coordinator: spy)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(spy, file: file, line: line)

        return (sut, spy)
    }
}

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
