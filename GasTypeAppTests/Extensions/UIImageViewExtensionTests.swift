//
//  UIImageViewExtensionTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import UIKit
import XCTest
@testable import GasTypeApp

final class UIImageViewExtensionTests: XCTestCase {
    func test_makeImageView_shouldUseScaleAspectFitContentMode() {
        let imageView = UIImageView.makeImageView("LOGO")

        XCTAssertEqual(imageView.contentMode, .scaleAspectFit)
    }

    func test_makeImageView_withExistingAsset_shouldLoadImage() {
        let imageView = UIImageView.makeImageView("LOGO")

        XCTAssertNotNil(imageView.image)
    }

    func test_makeImageView_withUnknownAsset_shouldHaveNilImage() {
        let imageView = UIImageView.makeImageView("a-non-existing-asset-name")

        XCTAssertNil(imageView.image)
    }
}
