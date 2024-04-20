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
}
