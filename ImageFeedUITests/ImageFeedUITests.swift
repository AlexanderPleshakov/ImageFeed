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
        print(app.debugDescription)
    }

    func testAuth() throws {
        // Нажать кнопку авторизации
            // Подождать, пока экран авторизации открывается и загружается
            // Ввести данные в форму
            // Нажать кнопку логина
            // Подождать, пока открывается экран ленты
        app.buttons["Auth"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        loginTextField.tap()
        loginTextField.typeText("")
        webView.swipeUp()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText("")
        webView.swipeUp()
        
        let loginButton = webView.descendants(matching: .button).element
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() throws {
        
    }
    
    func testProfile() throws {
        
    }
}
