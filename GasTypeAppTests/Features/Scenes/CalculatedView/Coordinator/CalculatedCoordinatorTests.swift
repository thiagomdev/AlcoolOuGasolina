//
//  CalculatedCoordinatorTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class CalculatedCoordinatorTests: XCTestCase {
    func test_start_fromGas_shouldSetCalculatedViewControllerWithGasLabelAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.start(from: .gas)

        let calculated = topViewController(in: window) as? CalculatedViewController
        XCTAssertNotNil(calculated)
        XCTAssertEqual(calculated?.calculatedPriceLabel.text, GasType.gas.rawValue)

        window.rootViewController = nil
    }

    func test_start_fromEthanol_shouldSetCalculatedViewControllerWithEthanolLabelAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.start(from: .ethanol)

        let calculated = topViewController(in: window) as? CalculatedViewController
        XCTAssertNotNil(calculated)
        XCTAssertEqual(calculated?.calculatedPriceLabel.text, GasType.ethanol.rawValue)

        window.rootViewController = nil
    }

    func test_calculatePriceAgain_shouldSetCalculatorViewControllerAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.calculatePriceAgain()

        XCTAssertTrue(topViewController(in: window) is GasTypeCalculatorViewController)

        window.rootViewController = nil
    }
}

extension CalculatedCoordinatorTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: CalculatedCoordinator, window: UIWindow) {
        let window = UIWindow()
        let sut = CalculatedCoordinator(
            window: window,
            navigation: UINavigationController()
        )

        return (sut, window)
    }

    private func topViewController(in window: UIWindow) -> UIViewController? {
        (window.rootViewController as? UINavigationController)?.viewControllers.first
    }
}
