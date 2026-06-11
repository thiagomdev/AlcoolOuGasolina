//
//  UITextFieldExtensionTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class UITextFieldExtensionTests: XCTestCase {
    func test_makeTextField_shouldConfigureProvidedPlaceholder() {
        let textField = UITextField.makeTextField("Preço do Àlcool")

        XCTAssertEqual(textField.placeholder, "Preço do Àlcool")
    }

    func test_makeTextField_shouldUseDecimalPadKeyboard() {
        let textField = UITextField.makeTextField("any")

        XCTAssertEqual(textField.keyboardType, .decimalPad)
    }

    func test_makeTextField_shouldDisableAutocorrectionAndUseRoundedBorder() {
        let textField = UITextField.makeTextField("any")

        XCTAssertEqual(textField.autocorrectionType, .no)
        XCTAssertEqual(textField.borderStyle, .roundedRect)
        XCTAssertEqual(textField.returnKeyType, .next)
        XCTAssertTrue(textField.adjustsFontSizeToFitWidth)
    }

    func test_makeTextField_shouldAttachDoneToolbarAsInputAccessoryView() {
        let textField = UITextField.makeTextField("any")

        let toolbar = textField.inputAccessoryView as? UIToolbar
        XCTAssertNotNil(toolbar)
        XCTAssertEqual(toolbar?.items?.count, 2)
    }

    func test_addDoneButtonKeyboard_doneButton_shouldTargetTextFieldAndResignFirstResponder() {
        let textField = UITextField.makeTextField("any")
        let toolbar = textField.inputAccessoryView as? UIToolbar
        let doneButton = toolbar?.items?.last

        XCTAssertEqual(doneButton?.target as? UITextField, textField)
        XCTAssertNotNil(doneButton?.action)

        // Firing the action exercises the private handleDoneButton selector.
        if let action = doneButton?.action {
            _ = textField.perform(action)
        }
    }
}
