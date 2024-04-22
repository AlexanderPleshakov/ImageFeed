//
//  ImagesListTests.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 21.04.2024.
//

import XCTest
@testable import ImageFeed

final class ImagesListTests: XCTestCase {    
    func testGetPhotosCount() {
        // given
        let presenter = ImagesListPresenter()
        
        // when
        let count = presenter.getPhotosCount()
        
        // then
        XCTAssertEqual(count, 0)
    }
    
    func testGetPhoto() {
        // given
        let presenter = ImagesListPresenter()
        
        // when
        let photo = presenter.getPhoto(at: 1)
        
        // then
        XCTAssertNil(photo)
    }
    
    func testUpdatePhotosAndGetCounts() {
        // given
        let presenter = ImagesListPresenter()
        
        // when
        let (new, old) = presenter.updatePhotosAndGetCounts()
        
        // then
        XCTAssertEqual(new, 0)
        XCTAssertEqual(old, 0)
    }
    
    func testViewControllerCallsViewDidLoad() {
        // given
        let presenter = ImagesListPresenterSpy()
        let viewController = ImagesListViewController(presenter: presenter)
        presenter.view = viewController
        
        // when
        _ = viewController.view
        
        // then
        XCTAssertTrue(presenter.isViewDidLoad)
    }
}
