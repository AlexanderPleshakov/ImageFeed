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

        app.launchArguments = ["testMode"]
        app.launch()
    }

    override func tearDownWithError() throws {
        print(app.debugDescription)
    }
    
    private func dismissKeyboardIfPresent() {
        if app.keyboards.element(boundBy: 0).exists {
            if UIDevice.current.userInterfaceIdiom == .pad {
                app.keyboards.buttons["Hide keyboard"].tap()
            } else {
                app.toolbars.buttons["Done"].tap()
            }
        }
    }

    func testAuth() throws {
        app.buttons["Auth"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        loginTextField.tap()
        loginTextField.typeText("your email")
        dismissKeyboardIfPresent()
        //webView.swipeUp()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText("your password")
        dismissKeyboardIfPresent()
        //webView.swipeUp()
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() throws {
        let tablesQuery = app.tables
        
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tablesQuery.descendants(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["LikeButton"].tap()
        sleep(1)
        cellToLike.buttons["LikeButton"].tap()
        
        sleep(2)
        
        cellToLike.tap()
        
        sleep(2)
        
        let image = app.scrollViews.images.element(boundBy: 0)

        image.pinch(withScale: 2, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        let navBackButton = app.buttons["BackToImagesListButton"]
        navBackButton.tap()
        
        let cellAfterLike = tablesQuery.descendants(matching: .cell).element(boundBy: 1)
        
        XCTAssertTrue(cellAfterLike.waitForExistence(timeout: 5))
    }
    
    func testProfile() throws {
        let tab = app.tabBars.buttons.element(boundBy: 1)
        XCTAssertTrue(tab.waitForExistence(timeout: 5))
        tab.tap()
        
        sleep(1)
        
        XCTAssertTrue(app.staticTexts["Александр Плешаков"].exists)
        XCTAssertTrue(app.staticTexts["@alexanderpleshakov"].exists)
        
        app.buttons["LogoutButton"].tap()
        app.alerts["TwoButtonsAlert"].scrollViews.otherElements.buttons["Да"].tap()
        
        XCTAssertTrue(app.buttons["Auth"].waitForExistence(timeout: 5))
    }
}
