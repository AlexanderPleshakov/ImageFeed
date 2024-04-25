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
        let sut = ImagesListPresenter()
        
        // when
        let count = sut.getPhotosCount()
        
        // then
        XCTAssertEqual(count, 0)
    }
    
    func testGetPhoto() {
        // given
        let sut = ImagesListPresenter(view: nil, imagesListService: ImagesListServiceStub())
        
        // when
        let photo = sut.getPhoto(at: 0)
        XCTAssertTrue(photo?.id == "0")
    }
    
    func testUpdatePhotosAndGetCounts() {
        // given
        let sut = ImagesListPresenter(view: nil, imagesListService: ImagesListServiceStub())
        
        // when
        let (new, old) = sut.updatePhotosAndGetCounts()
        
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
    
    func testViewControllerCallsUpdatePhotos() {
        // given
        let presenter = ImagesListPresenterSpy()
        let viewController = ImagesListViewController(presenter: presenter)
        presenter.view = viewController
        
        // when
        viewController.updateTableViewAnimated()
        
        // then
        XCTAssertTrue(presenter.isUpdatePhotosCalled)
    }
    
    func testShowingProgressHUD() {
        // given
        let presenter = ImagesListPresenterStub()
        let viewController = ImagesListViewControllerSpy()
        presenter.view = viewController
        
        // when
        presenter.changeLike(at: 0) { _ in }
        
        // then
        XCTAssertTrue(viewController.isShowedProgressHUD)
    }
    
    func testChangeLike() {
        // given
        let sut = ImagesListServiceStub()// ImagesListPresenter(view: nil, imagesListService: ImagesListServiceStub())
        var isLike = false
        
        // when
        sut.changeLike(photoId: "0", isLiked: isLike) { result in
            switch result {
            case .success(let photo):
                isLike = photo.isLiked
            case .failure(let error):
                XCTFail()
            }
        }
        
        // then
        XCTAssertTrue(isLike)
    }
    
}
