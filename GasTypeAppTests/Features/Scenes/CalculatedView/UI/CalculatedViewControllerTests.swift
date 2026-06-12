//
//  CalculatedViewControllerTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class CalculatedViewControllerTests: XCTestCase {
    func test_viewDidLoad_shouldBuildViewHierarchyAndConfigureBackground() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.view.subviews.isEmpty)
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }

    func test_viewDidLoad_shouldAddCalculateAgainButton() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.view.firstButton(withTitle: "CALCULAR NOVAMENTE"))
    }

    func test_calculatedPriceLabel_shouldBeAccessibleForRouting() {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()

        sut.calculatedPriceLabel.text = GasType.gas.rawValue

        XCTAssertEqual(sut.calculatedPriceLabel.text, GasType.gas.rawValue)
    }

    func test_viewWillAppear_shouldHideNavigationBar() {
        let (sut, _) = makeSut()
        let navigation = UINavigationController(rootViewController: sut)

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        XCTAssertTrue(navigation.isNavigationBarHidden)
    }

    func test_tapCalculateAgainButton_shouldAskViewModelToCalculatePrice() {
        let (sut, spy) = makeSut()
        sut.loadViewIfNeeded()

        sut.view.firstButton(withTitle: "CALCULAR NOVAMENTE")?.simulateTap()

        XCTAssertEqual(spy.messages, [.calculatePrice])
    }
}

extension CalculatedViewControllerTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: CalculatedViewController, spy: CalculatedViewModelingSpy) {
        let spy = CalculatedViewModelingSpy()
        let sut = CalculatedViewController(viewModel: spy)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(spy, file: file, line: line)

        return (sut, spy)
    }
}
