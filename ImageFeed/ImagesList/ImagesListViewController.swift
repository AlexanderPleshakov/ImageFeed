//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 06.02.2024.
//

import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController {
    
    //MARK: Properties
    private let imagesListService = ImagesListService()
    private var photos = [Photo]()
    
    private var imagesListCell: ImagesListCell!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ImagesListCell.self, forCellReuseIdentifier: ImagesListCell.reuseIdentifier)
        tableView.backgroundColor = UIColor(named: "YP Black")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        NotificationCenter.default.addObserver(
            forName: ImagesListService.didChangeNotification,
            object: nil,
            queue: .main) { [weak self] _ in
                print("-- Notification --")
                guard let self = self else { return }
                self.updateTableViewAnimated()
        }
        if !photos.isEmpty {
            updateTableViewAnimated()
        }
        
        imagesListService.fetchPhotosNextPage()
    }
    
    // MARK: Functions
    
    private func updateTableViewAnimated() {
        print("-- update --")
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        
        tableView.performBatchUpdates {
            let indexPaths = (oldCount..<newCount).map { i in
                IndexPath(row: i, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }

    }
    
    private func configure() {
        view.backgroundColor = UIColor(named: "YP Black")
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//MARK: UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleImageViewController = SingleImageViewController()
        guard let url = URL(string: photos[indexPath.row].largeImageURL) else { return }
        
        singleImageViewController.imageURL = url
        singleImageViewController.modalPresentationStyle = .fullScreen
        present(singleImageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = photos[indexPath.row].size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = photos[indexPath.row].size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

//MARK: UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(named: "YP Black")
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        imageListCell.selectionStyle = .none
        imageListCell.configCell(in: tableView, for: imageListCell, with: indexPath, photo: photos[indexPath.row])
        
        if indexPath.row == photos.count - 1 {
            imagesListService.fetchPhotosNextPage()
        }
        return imageListCell
    }
}
