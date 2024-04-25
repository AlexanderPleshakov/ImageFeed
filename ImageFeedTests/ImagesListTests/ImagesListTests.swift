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
        let service = ImagesListServiceStub()
        service.clearBeforeLogout()
        let sut = ImagesListPresenter(view: nil, imagesListService: service)
        
        // when
        let (_, _) = sut.updatePhotosAndGetCounts()
        let photo = sut.getPhoto(at: 0)
        XCTAssertTrue(photo?.id == "0")
    }
    
    func testUpdatePhotosAndGetCounts() {
        // given
        let service = ImagesListServiceStub()
        service.clearBeforeLogout()
        let sut = ImagesListPresenter(view: nil, imagesListService: service)
        
        // when
        let (old, new) = sut.updatePhotosAndGetCounts()
        
        // then
        XCTAssertEqual(old, 0)
        XCTAssertEqual(new, 1)
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
            case .failure(_):
                XCTFail()
            }
        }
        
        // then
        XCTAssertTrue(isLike)
    }
    
    func testViewDidLoadNotification() {
        let viewController = ImagesListViewControllerSpy()
        let service = ImagesListServiceStub()
        service.clearBeforeLogout()
        let sut = ImagesListPresenter(view: viewController, imagesListService: service)
        sut.view = viewController
        
        sut.viewDidLoad()
        
        XCTAssertTrue(viewController.isCalledUpdateTable)
    }
    
    func testUpdatingPresenterPhotosCount() {
        let service = ImagesListServiceStub()
        service.clearBeforeLogout()
        let view = ImagesListViewControllerFake()
        let sut = ImagesListPresenter(imagesListService: service)
        sut.view = view
        view.presenter = sut
        
        sut.viewDidLoad()
        let count = sut.getPhotosCount()
        
        XCTAssertEqual(count, 2)
    }
    
    func testShouldGetNextPage() {
        let service = ImagesListServiceStub()
        service.clearBeforeLogout()
        let view = ImagesListViewControllerFake()
        let sut = ImagesListPresenter(imagesListService: service)
        sut.view = view
        view.presenter = sut
        
        sut.viewDidLoad()
        
        let startCount = sut.getPhotosCount()
        sut.shouldGetNextPage(for: 1)
        let newCount = sut.getPhotosCount()
        
        XCTAssertEqual(startCount + 1, newCount)
    }
    
}
