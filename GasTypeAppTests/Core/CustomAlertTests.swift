//
//  CustomAlertTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class CustomAlertTests: XCTestCase {
    func test_showAlert_shouldPresentAlertControllerWithGivenTitleAndMessage() {
        let host = UIViewController()
        let window = UIWindow()
        window.rootViewController = host
        window.makeKeyAndVisible()

        let sut = CustomAlert(view: host)
        sut.showAlert(title: "Atenção!", message: "Mensagem de teste")

        let presented = host.presentedViewController as? UIAlertController
        XCTAssertNotNil(presented)
        XCTAssertEqual(presented?.title, "Atenção!")
        XCTAssertEqual(presented?.message, "Mensagem de teste")

        window.rootViewController = nil
    }

    func test_showAlert_shouldAddSingleOkAction() {
        let host = UIViewController()
        let window = UIWindow()
        window.rootViewController = host
        window.makeKeyAndVisible()

        let sut = CustomAlert(view: host)
        sut.showAlert(title: "any", message: "any")

        let presented = host.presentedViewController as? UIAlertController
        XCTAssertEqual(presented?.actions.count, 1)
        XCTAssertEqual(presented?.actions.first?.title, "OK")
        XCTAssertEqual(presented?.actions.first?.style, .default)

        window.rootViewController = nil
    }
}
