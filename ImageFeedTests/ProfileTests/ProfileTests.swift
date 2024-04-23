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
}
