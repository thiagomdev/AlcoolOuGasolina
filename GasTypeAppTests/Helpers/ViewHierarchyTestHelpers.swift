//
//  ViewHierarchyTestHelpers.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit

extension UIView {
    /// Recursively collects every subview of the given type in the hierarchy.
    func allSubviews<T: UIView>(ofType type: T.Type) -> [T] {
        var result = [T]()
        for subview in subviews {
            if let match = subview as? T {
                result.append(match)
            }
            result.append(contentsOf: subview.allSubviews(ofType: type))
        }
        return result
    }

    /// Finds the first button whose title matches `title`.
    func firstButton(withTitle title: String) -> UIButton? {
        allSubviews(ofType: UIButton.self).first { $0.title(for: .normal) == title }
    }
}

extension UIButton {
    /// Simulates a tap by firing the `.touchUpInside` control event.
    func simulateTap() {
        sendActions(for: .touchUpInside)
    }
}
