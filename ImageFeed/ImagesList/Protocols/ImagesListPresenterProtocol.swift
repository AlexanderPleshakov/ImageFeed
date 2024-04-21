//
//  ImagesListPresenterProtocol.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 21.04.2024.
//

import Foundation

protocol ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func photosCount() -> Int
    func getPhoto(at index: Int) -> Photo
    func updatePhotos()
    func nextPage()
    func shouldGetNextPage(for index: Int)
    func changeLike(at index: Int, _ completion: @escaping (Result<Bool, Error>) -> Void)
}
