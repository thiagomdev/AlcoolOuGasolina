//
//  GasTypeCalculatorViewControllerTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class GasTypeCalculatorViewControllerTests: XCTestCase {
    func test_viewDidLoad_shouldBuildViewHierarchyAndConfigureBackground() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.view.subviews.isEmpty)
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }

    func test_viewDidLoad_shouldAddCalculateButtonAndTwoTextFields() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.view.firstButton(withTitle: "CALCULAR"))
        XCTAssertEqual(sut.view.allSubviews(ofType: UITextField.self).count, 2)
    }

    func test_viewWillAppear_shouldHideNavigationBar() {
        let (sut, _) = makeSut()
        let navigation = UINavigationController(rootViewController: sut)

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        XCTAssertTrue(navigation.isNavigationBarHidden)
    }

    func test_tapCalculateButton_shouldAskViewModelToCalculatePriceWithFieldValues() {
        let (sut, spy) = makeSut()
        sut.loadViewIfNeeded()

        sut.view.firstButton(withTitle: "CALCULAR")?.simulateTap()

        XCTAssertEqual(spy.messages, [.calculatePrice(ethanol: "", gas: "")])
        XCTAssertNotNil(spy.showAlert)
        // The `showAlert` closure captures `self` weakly, so the leak tracker in
        // makeSut also guards against the retain cycle regressing.
    }

    func test_showAlertClosure_shouldPresentCustomAlert() {
        // No leak tracking here: presenting a UIAlertController with animation
        // retains the view controller non-deterministically in a unit-test host.
        let spy = GasTypeCalculatorViewModelingSpy()
        let sut = GasTypeCalculatorViewController(viewModel: spy)
        let window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        sut.loadViewIfNeeded()

        sut.view.firstButton(withTitle: "CALCULAR")?.simulateTap()
        spy.showAlert?()

        XCTAssertTrue(sut.presentedViewController is UIAlertController)

        spy.showAlert = nil
        window.rootViewController = nil
    }

    func test_tapBackButton_shouldAskViewModelToGoBackHome() {
        let (sut, spy) = makeSut()
        sut.loadViewIfNeeded()

        let backButton = sut.view.allSubviews(ofType: UIButton.self).first { $0.title(for: .normal) == nil }
        backButton?.simulateTap()

        XCTAssertEqual(spy.messages, [.backToHome])
    }

    func test_touchesBegan_shouldNotCrashWhileEndingEditing() {
        let (sut, _) = makeSut()
        sut.loadViewIfNeeded()

        sut.touchesBegan([], with: nil)

        XCTAssertNotNil(sut.view)
    }
}

extension GasTypeCalculatorViewControllerTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: GasTypeCalculatorViewController, spy: GasTypeCalculatorViewModelingSpy) {
        let spy = GasTypeCalculatorViewModelingSpy()
        let sut = GasTypeCalculatorViewController(viewModel: spy)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(spy, file: file, line: line)

        return (sut, spy)
    }
}
