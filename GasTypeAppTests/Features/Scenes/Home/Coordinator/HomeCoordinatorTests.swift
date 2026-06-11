//
//  HomeCoordinatorTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class HomeCoordinatorTests: XCTestCase {
    func test_openGasTypeView_shouldStartGasTypeCoordinator() {
        let (sut, _, gasTypeSpy) = makeSut()

        sut.openGasTypeView()

        XCTAssertEqual(gasTypeSpy.messages, [.start])
    }

    func test_start_shouldSetHomeViewControllerAsWindowRoot() {
        let (sut, window, _) = makeSut()

        sut.start()

        XCTAssertTrue(window.rootViewController is UINavigationController)
        XCTAssertTrue(topViewController(in: window) is HomeViewController)

        window.rootViewController = nil
    }
}

extension HomeCoordinatorTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: HomeCoordinator, window: UIWindow, gasTypeSpy: GasTypeCalculatorCoordinatingSpy) {
        let window = UIWindow()
        let gasTypeSpy = GasTypeCalculatorCoordinatingSpy()
        let sut = HomeCoordinator(
            window: window,
            navigation: UINavigationController(),
            gasTypeCoordinator: gasTypeSpy
        )

        trackForMemoryLeaks(gasTypeSpy, file: file, line: line)

        return (sut, window, gasTypeSpy)
    }

    private func topViewController(in window: UIWindow) -> UIViewController? {
        (window.rootViewController as? UINavigationController)?.viewControllers.first
    }
}
