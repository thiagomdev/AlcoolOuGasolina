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
        let (sut, doubles) = makeSut()

        sut.openGasTypeView()

        XCTAssertEqual(doubles.gasTypeSpy.messages, [.start])
    }

    func test_start_shouldSetHomeViewControllerAsWindowRoot() {
        let (sut, doubles) = makeSut()

        sut.start()

        XCTAssertTrue(doubles.window.rootViewController is UINavigationController)
        XCTAssertTrue(topViewController(in: doubles.window) is HomeViewController)

        doubles.window.rootViewController = nil
    }
}

extension HomeCoordinatorTests {
    private typealias Doubles = (
        window: UIWindow,
        gasTypeSpy: GasTypeCalculatorCoordinatingSpy
    )
    
    private func makeSut(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (
        sut: HomeCoordinator,
        doubles: Doubles
    ) {
        let window = UIWindow()
        let gasTypeSpy = GasTypeCalculatorCoordinatingSpy()
        let sut = HomeCoordinator(
            window: window,
            navigation: UINavigationController(),
            gasTypeCoordinator: gasTypeSpy
        )

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(gasTypeSpy, file: file, line: line)

        return (sut, (window, gasTypeSpy))
    }

    private func topViewController(in window: UIWindow) -> UIViewController? {
        (window.rootViewController as? UINavigationController)?.viewControllers.first
    }
}
