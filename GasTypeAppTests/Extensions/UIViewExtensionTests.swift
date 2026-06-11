//
//  UIViewExtensionTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class UIViewExtensionTests: XCTestCase {
    func test_addSubviews_shouldAddAllProvidedViewsAsSubviews() {
        let container = UIView()
        let first = UIView()
        let second = UIView()
        let third = UIView()

        container.add(subviews: first, second, third)

        XCTAssertEqual(container.subviews, [first, second, third])
    }

    func test_addSubviews_shouldSetContainerAsSuperview() {
        let container = UIView()
        let child = UIView()

        container.add(subviews: child)

        XCTAssertEqual(child.superview, container)
    }

    func test_addSubviews_whenCalledWithNoViews_shouldNotAddAnything() {
        let container = UIView()

        container.add()

        XCTAssertTrue(container.subviews.isEmpty)
    }
}
