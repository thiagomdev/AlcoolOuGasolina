//
//  GasTypeCalculatorCoordinatorTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class GasTypeCalculatorCoordinatorTests: XCTestCase {
    func test_start_shouldSetCalculatorViewControllerAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.start()

        XCTAssertTrue(window.rootViewController is UINavigationController)
        XCTAssertTrue(topViewController(in: window) is GasTypeCalculatorViewController)

        window.rootViewController = nil
    }

    func test_backToHome_shouldSetHomeViewControllerAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.backToHome()

        XCTAssertTrue(topViewController(in: window) is HomeViewController)

        window.rootViewController = nil
    }

    func test_displayCalculatedPrice_fromGas_shouldShowCalculatedViewControllerWithGasLabel() {
        let (sut, window) = makeSut()

        sut.displayCalculatedPrice(from: .gas)

        let calculated = topViewController(in: window) as? CalculatedViewController
        XCTAssertNotNil(calculated)
        XCTAssertEqual(calculated?.calculatedPriceLabel.text, GasType.gas.rawValue)

        window.rootViewController = nil
    }

    func test_displayCalculatedPrice_fromEthanol_shouldShowCalculatedViewControllerWithEthanolLabel() {
        let (sut, window) = makeSut()

        sut.displayCalculatedPrice(from: .ethanol)

        let calculated = topViewController(in: window) as? CalculatedViewController
        XCTAssertNotNil(calculated)
        XCTAssertEqual(calculated?.calculatedPriceLabel.text, GasType.ethanol.rawValue)

        window.rootViewController = nil
    }
}

extension GasTypeCalculatorCoordinatorTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: GasTypeCalculatorCoordinator, window: UIWindow) {
        let window = UIWindow()
        let sut = GasTypeCalculatorCoordinator(
            window: window,
            navigation: UINavigationController(),
            calculatedCoordinator: CalculatedCoordinatingSpy()
        )

        return (sut, window)
    }

    private func topViewController(in window: UIWindow) -> UIViewController? {
        (window.rootViewController as? UINavigationController)?.viewControllers.first
    }
}
