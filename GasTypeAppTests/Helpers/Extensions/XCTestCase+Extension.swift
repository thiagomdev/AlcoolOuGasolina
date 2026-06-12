//
//  XCTestCase+Extension.swift
//  GasTypeApp
//
//  Created by Thiago Monteiro on 6/12/26.
//

import XCTest
extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been delocated. Potential memory leak",
                file: file,
                line: line
            )
        }
    }
}
