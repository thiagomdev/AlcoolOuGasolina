//
//  AppCoordinatorTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class AppCoordinatorTests: XCTestCase {
    func test_start_shouldSetHomeViewControllerAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.start()

        XCTAssertTrue(window.rootViewController is UINavigationController)
        XCTAssertTrue(topViewController(in: window) is HomeViewController)

        window.rootViewController = nil
    }

    func test_displayCalculatorView_shouldSetCalculatorViewControllerAsWindowRoot() {
        let (sut, window) = makeSut()

        sut.displayCalculatorView()

        XCTAssertTrue(topViewController(in: window) is GasTypeCalculatorViewController)

        window.rootViewController = nil
    }

    func test_displayCalculatedPriceView_fromGas_shouldShowCalculatedViewControllerWithGasLabel() {
        let (sut, window) = makeSut()

        sut.displayCalculatedPriceView(from: .gas)

        let calculated = topViewController(in: window) as? CalculatedViewController
        XCTAssertNotNil(calculated)
        XCTAssertEqual(calculated?.calculatedPriceLabel.text, GasType.gas.rawValue)

        window.rootViewController = nil
    }
}

extension AppCoordinatorTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: AppCoordinator, window: UIWindow) {
        let window = UIWindow()
        let navigation = UINavigationController()

        let calculatedCoordinator = CalculatedCoordinator(window: window, navigation: navigation)
        let gasTypeCoordinator = GasTypeCalculatorCoordinator(
            window: window,
            navigation: navigation,
            calculatedCoordinator: calculatedCoordinator
        )
        let homeCoordinator = HomeCoordinator(
            window: window,
            navigation: navigation,
            gasTypeCoordinator: gasTypeCoordinator
        )
        let sut = AppCoordinator(
            window: window,
            navigation: navigation,
            homeCoordinator: homeCoordinator,
            gasTypeCoordinator: gasTypeCoordinator,
            calculatedCoordinator: calculatedCoordinator
        )

        return (sut, window)
    }

    private func topViewController(in window: UIWindow) -> UIViewController? {
        (window.rootViewController as? UINavigationController)?.viewControllers.first
    }
}
