//
//  WebViewTests.swift
//  WebViewTests
//
//  Created by Александр Плешаков on 20.04.2024.
//

import XCTest
@testable import ImageFeed

final class WebViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        // given
        let viewController = WebViewController()
        let presenter = WebViewPresenterSpy()
        presenter.view = viewController
        viewController.presenter = presenter
        
        // when
        _ = viewController.view
        
        // then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsLoadRequest() {
        // given
        let viewController = WebViewControllerSpy()
        let authHelper = AuthHelperFake()
        let presenter = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = presenter
        presenter.view = viewController
        
        // when
        presenter.viewDidLoad()
        
        // then
        XCTAssertTrue(viewController.loadIsCalled)
    }
    
    func testShouldHideProgress() {
        // given
        let authHelper = AuthHelperDummy()
        let presenter = WebViewPresenter(authHelper: authHelper)
        
        // when
        let shouldHideProgress = presenter.shouldHideProgress(for: 1)
        
        // then
        XCTAssertTrue(shouldHideProgress)
    }
}
