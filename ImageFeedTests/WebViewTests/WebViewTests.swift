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
        let sut = WebViewController()
        let presenter = WebViewPresenterSpy()
        presenter.view = sut
        sut.presenter = presenter
        
        // when
        _ = sut.view
        
        // then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testPresenterCallsLoadRequest() {
        // given
        let viewController = WebViewControllerSpy()
        let authHelper = AuthHelperFake()
        let sut = WebViewPresenter(authHelper: authHelper)
        viewController.presenter = sut
        sut.view = viewController
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertTrue(viewController.loadIsCalled)
    }
    
    func testShouldHideProgress() {
        // given
        let authHelper = AuthHelperDummy()
        let sut = WebViewPresenter(authHelper: authHelper)
        
        // when
        let shouldHideProgress = sut.shouldHideProgress(for: 1)
        
        // then
        XCTAssertTrue(shouldHideProgress)
    }
    
    func testAuthHelperAuthURL() {
        //given
        let configuration = AuthConfiguration.standard
        let sut = AuthHelper(configuration: configuration)
        
        //when
        let url = sut.authURL()
        let urlString = url?.absoluteString
        
        //then
        XCTAssertEqual(urlString?.contains(configuration.authURLString), true)
        XCTAssertEqual(urlString?.contains(configuration.accessKey), true)
        XCTAssertEqual(urlString?.contains(configuration.redirectURI), true)
        XCTAssertEqual(urlString?.contains("code"), true)
        XCTAssertEqual(urlString?.contains(configuration.accessScope), true)
    }
    
    func testCodeFromURL() {
        // given
        var components = URLComponents(string: "https://unsplash.com/oauth/authorize/native")
        components?.queryItems = [URLQueryItem(name: "code", value: "test code")]
        let url = components?.url
        
        let sut = AuthHelper()
        
        // when
        var code: String = ""
        if let url = url {
            code = sut.code(from: url) ?? ""
        } else {
            XCTFail("url is nil")
        }
        
        // then
        XCTAssertEqual(code, "test code")
        
    }
}
