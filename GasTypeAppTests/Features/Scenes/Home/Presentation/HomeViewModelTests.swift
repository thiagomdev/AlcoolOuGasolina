//
//  HomeViewModelTests.swift
//  GasTypeAppTests
//
//  Created by Thiago Monteiro on 6/10/26.
//

import XCTest
@testable import GasTypeApp

final class HomeViewModelTests: XCTestCase {
    func test_openGasTypeView_ShouldCallCoordinatorToOpenGasTypeView() {
        let (sut, homeCoordinatingSpy) = makeSut()
        
        sut.openGasTypeView()
        
        XCTAssertEqual(homeCoordinatingSpy.messages, [.openGasTypeView])
    }
}

extension HomeViewModelTests {
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> (sut: HomeViewModel, homeCoordinating: HomeCoordinatingSpy) {
        let homeCoordinatingSpy = HomeCoordinatingSpy()
        let sut = HomeViewModel(coordinator: homeCoordinatingSpy)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(homeCoordinatingSpy, file: file, line: line)
        
        return (sut, homeCoordinatingSpy)
    }
}

final class HomeCoordinatingSpy: HomeCoordinating {
    enum Message {
        case start
        case openGasTypeView
    }
    
    private(set) var messages = [Message]()
    
    func start() {
        messages.append(.start)
    }
    
    func openGasTypeView() {
        messages.append(.openGasTypeView)
    }
}

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
