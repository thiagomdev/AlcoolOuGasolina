import XCTest
import UIKit
@testable import GasTypeApp

final class HomeViewControllerTests: XCTestCase {

    func test_viewDidLoad_buildsHierarchyAndConfiguresAppearance() {
        let sut = makeSUT()

        sut.loadViewIfNeeded()

        XCTAssertEqual(subviews(ofType: UIImageView.self, in: sut.view).count, 2)
        XCTAssertNotNil(findStartButton(in: sut.view))
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }

    func test_viewWillAppear_hidesNavigationBar() {
        let sut = makeSUT()
        let navigation = UINavigationController(rootViewController: sut)

        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)

        XCTAssertTrue(navigation.isNavigationBarHidden)
    }

    func test_tapStartButton_requestsGasTypeNavigation() {
        let viewModel = HomeViewModelSpy()
        let sut = makeSUT(viewModel: viewModel)

        sut.loadViewIfNeeded()
        let button = findStartButton(in: sut.view)
        XCTAssertNotNil(button, "COMEÇAR button should exist in the view hierarchy")

        button?.sendActions(for: .touchUpInside)

        XCTAssertEqual(viewModel.openGasTypeViewCallCount, 1)
    }

    // MARK: - Helpers

    private func makeSUT(viewModel: HomeViewModeling = HomeViewModelSpy(),
                         file: StaticString = #filePath,
                         line: UInt = #line) -> HomeViewController {
        let sut = HomeViewController(viewModel: viewModel)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(viewModel as AnyObject, file: file, line: line)
        return sut
    }

    private func findStartButton(in view: UIView) -> UIButton? {
        if let button = view as? UIButton {
            return button
        }

        for subview in view.subviews {
            if let button = findStartButton(in: subview) {
                return button
            }
        }

        return nil
    }

    private func subviews<T: UIView>(ofType type: T.Type, in view: UIView) -> [T] {
        var result: [T] = []

        if let matching = view as? T {
            result.append(matching)
        }

        view.subviews.forEach { subview in
            result.append(contentsOf: subviews(ofType: type, in: subview))
        }

        return result
    }

    private func trackForMemoryLeaks(_ instance: AnyObject,
                                     file: StaticString = #filePath,
                                     line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}

private final class HomeViewModelSpy: HomeViewModeling {
    private(set) var openGasTypeViewCallCount = 0

    func openGasTypeView() {
        openGasTypeViewCallCount += 1
    }
}
