//
//  ProfileTests.swift
//  ImageFeedTests
//
//  Created by Александр Плешаков on 23.04.2024.
//

@testable import ImageFeed
import XCTest

final class ProfileTests: XCTestCase {
    func testPresenterCallsSetAvatar() {
        // given
        let viewController = ProfileViewControllerSpy()
        let sut = ProfilePresenter(view: viewController,
                                   logoutService: ProfileLogoutServiceStub.shared,
                                   profileService: ProfileServiceStub.shared,
                                   profileImageService: ProfileImageServiceStub.shared)
        viewController.presenter = sut
        
        // when
        sut.updateAvatar()
        
        // then
        XCTAssertTrue(viewController.isAvatarSet)
    }
    
    func testPresenterCallsConfigure() {
        // given
        let viewController = ProfileViewControllerSpy()
        let sut = ProfilePresenter(view: viewController,
                                   logoutService: ProfileLogoutServiceStub.shared,
                                   profileService: ProfileServiceStub.shared,
                                   profileImageService: ProfileImageServiceStub.shared)
        viewController.presenter = sut
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertTrue(viewController.isConfigure)
    }
    
    func testPresenterCallsAvatarImageUpdate() {
        // given
        let viewController = ProfileViewControllerSpy()
        let sut = ProfilePresenter(view: viewController,
                                   logoutService: ProfileLogoutServiceStub.shared,
                                   profileService: ProfileServiceStub.shared,
                                   profileImageService: ProfileImageServiceStub.shared)
        viewController.presenter = sut
        
        // when
        sut.viewDidLoad()
        
        // then
        XCTAssertTrue(viewController.isAvatarImageUpdated)
    }
    
    func testControllerCallsUpdateAvatar() {
        // given
        let sut = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        sut.presenter = presenter
        presenter.view = sut
        
        // when
        sut.updateAvatarImage()
        
        // then
        XCTAssertTrue(presenter.isAvatarUpdated)
    }
    
    func testControllerCallsViewDidLoad() {
        // given
        let sut = ProfileViewController()
        let presenter = ProfilePresenterSpy()
        sut.presenter = presenter
        presenter.view = sut
        
        // when
        _ = sut.view
        
        // then
        XCTAssertTrue(presenter.isViewDidLoad)
    }
    
    func testDoLogoutAction() {
        // given
        let sut = ProfilePresenter()
        
        // when
        sut.doLogoutAction()
        
        // then
        XCTAssertNil(ProfileImageService.shared.avatarURL)
        XCTAssertNil(ProfileService.shared.profile)
        XCTAssertTrue(ImagesListService.shared.photos.isEmpty)
    }
}
