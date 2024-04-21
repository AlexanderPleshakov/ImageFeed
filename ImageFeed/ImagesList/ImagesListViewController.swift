//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 06.02.2024.
//

import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController, ImagesListViewControllerProtocol {
    
    //MARK: Properties
    private var presenter: ImagesListPresenterProtocol
    private var imagesListCell: ImagesListCell!
    
    init(presenter: ImagesListPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                guard let self = self else { return }
                self.updateTableViewAnimated()
        }
        if presenter.getPhotosCount() == 0 {
            updateTableViewAnimated()
        }
        
        presenter.nextPage()
    }
    
    // MARK: Functions
    
    func updateTableViewAnimated() {
        let (oldCount, newCount) = presenter.updatePhotosAndGetCounts()
        
        tableView.performBatchUpdates {
            let indexPaths = (oldCount..<newCount).map { i in
                IndexPath(row: i, section: 0)
            }
            tableView.insertRows(at: indexPaths, with: .automatic)
        } completion: { _ in }
    }
    
    func showProgressHUD() {
        UIBlockingProgressHUD.show()
    }
    
    func dismissProgressHUD() {
        UIBlockingProgressHUD.dismiss()
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
        let url = presenter.getPhoto(at: indexPath.row).largeImageURL
        
        singleImageViewController.imageURL = url
        singleImageViewController.modalPresentationStyle = .fullScreen
        present(singleImageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        
        let photo = presenter.getPhoto(at: indexPath.row)
        let imageWidth = photo.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = photo.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.shouldGetNextPage(for: indexPath.row)
    }
}

//MARK: UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPhotosCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor(named: "YP Black")
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        let photo = presenter.getPhoto(at: indexPath.row)
        imageListCell.delegate = self
        imageListCell.selectionStyle = .none
        imageListCell.configCell(in: tableView, for: imageListCell, with: indexPath, photo: photo)
        
        return imageListCell
    }
}

extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        presenter.changeLike(at: indexPath.row) { [weak self] result in
            switch result {
            case .success(let isLiked):
                cell.setIsLiked(isLiked)
                self?.dismissProgressHUD()
            case .failure(let error):
                print(error)
            }
        }
    }
}
