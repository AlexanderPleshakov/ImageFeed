//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Александр Плешаков on 24.04.2024.
//

import XCTest
@testable import ImageFeed

final class ImageFeedUITests: XCTestCase {
    private let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuth() throws {
        
    }
    
    func testFeed() throws {
        
    }
    
    func testProfile() throws {
        
    }
}
