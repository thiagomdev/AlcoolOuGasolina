//
//  NSLayoutConstraintExtensionTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class NSLayoutConstraintExtensionTests: XCTestCase {
    func test_pin_shouldActivateAllConstraints() {
        let parent = UIView()
        let child = UIView()
        parent.add(subviews: child)

        let constraints = [
            child.topAnchor.constraint(equalTo: parent.topAnchor),
            child.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
        ]

        NSLayoutConstraint.pin(constraints)

        XCTAssertTrue(constraints.allSatisfy { $0.isActive })
    }

    func test_pin_shouldDisableAutoresizingMaskForViewsWithSuperview() {
        let parent = UIView()
        let child = UIView()
        parent.add(subviews: child)

        NSLayoutConstraint.pin([
            child.topAnchor.constraint(equalTo: parent.topAnchor)
        ])

        XCTAssertFalse(child.translatesAutoresizingMaskIntoConstraints)
    }

    func test_pin_withLayoutGuide_shouldDisableAutoresizingMaskForOwningView() {
        let parent = UIView()
        let child = UIView()
        parent.add(subviews: child)

        // Using a layout guide exercises the UILayoutGuide branch of `pin`.
        NSLayoutConstraint.pin([
            child.topAnchor.constraint(equalTo: parent.layoutMarginsGuide.topAnchor)
        ])

        XCTAssertFalse(child.translatesAutoresizingMaskIntoConstraints)
    }
}
