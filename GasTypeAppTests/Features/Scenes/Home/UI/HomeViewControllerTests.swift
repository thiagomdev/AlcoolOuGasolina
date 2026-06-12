//
//  HomeViewControllerTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class HomeViewControllerTests: XCTestCase {
    func test_viewDidLoad_shouldBuildViewHierarchyAndConfigureBackground() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.view.subviews.isEmpty)
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }

    func test_viewDidLoad_shouldAddStartButton() {
        let (sut, _) = makeSut()

        sut.loadViewIfNeeded()

        XCTAssertNotNil(sut.view.firstButton(withTitle: "COMEÇAR"))
    }

    func test_viewWillAppear_shouldHideNavigationBar() {
        let (sut, _) = makeSut()
        let navigation = UINavigationController(rootViewController: sut)

        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()

        XCTAssertTrue(navigation.isNavigationBarHidden)
    }

    func test_tapStartButton_shouldAskViewModelToOpenGasTypeView() {
        let (sut, spy) = makeSut()
        sut.loadViewIfNeeded()

        sut.view.firstButton(withTitle: "COMEÇAR")?.simulateTap()

        XCTAssertEqual(spy.messages, [.openGasTypeView])
    }
}

extension HomeViewControllerTests {
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: HomeViewController, spy: HomeViewModelingSpy) {
        let spy = HomeViewModelingSpy()
        let sut = HomeViewController(viewModel: spy)

        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(spy, file: file, line: line)

        return (sut, spy)
    }
}
