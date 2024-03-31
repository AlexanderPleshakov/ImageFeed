//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 08.02.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    //MARK: Properties
    
    static let reuseIdentifier = "ImageListCell"
    static let photosName = Array(0..<20).map { "\($0)" }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    //MARK: Outlets
    
//    @IBOutlet weak var cellGradientView: UIView!
//    @IBOutlet weak var cellDataLabel: UILabel!
//    @IBOutlet weak var cellLikeButton: UIButton!
//    @IBOutlet weak var cellImage: UIImageView!
    
    private let cellGradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cellDataLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cellLikeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cellImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: Functions
    
    private func doGradient(for view: UIView) {
        
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = view.bounds
        
        gradientMaskLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientMaskLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        let ypColor20 = UIColor(named: "YP Black")?.withAlphaComponent(0.2).cgColor
        let ypColor15 = UIColor(named: "YP Black")?.withAlphaComponent(0.15).cgColor
        gradientMaskLayer.colors = [ypColor20 ?? UIColor.black.withAlphaComponent(0.3).cgColor,
                                    ypColor15 ?? UIColor.black.withAlphaComponent(0.15).cgColor,
                                    UIColor.clear.cgColor]
        gradientMaskLayer.locations = [0, 0.7, 1]
        
        view.layer.mask = gradientMaskLayer
    }
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        setupSubviews(for: cell)
        setConstraints(for: cell)
        
        guard let likeImage = indexPath.row % 2 != 0 ? UIImage(named: "FavoritesNoActive") : UIImage(named: "FavoritesActive"),
              let mainImage = UIImage(named: "\(ImagesListCell.photosName[indexPath.row])")
        else { return }
        
        cell.doGradient(for: cell.cellGradientView)
        cell.cellImage.image = mainImage
        cell.cellDataLabel.text = dateFormatter.string(from: Date())
        cell.cellLikeButton.setImage(likeImage, for: .normal)
    }
    
    private func setupSubviews(for cell: ImagesListCell) {
        cell.addSubview(cellImage)
        cell.addSubview(cellGradientView)
        cell.addSubview(cellDataLabel)
        cell.addSubview(cellLikeButton)
    }
    
    private func setConstraints(for cell: ImagesListCell) {
        NSLayoutConstraint.activate([
            cellImage.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: 16),
            cellImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16),
            cellImage.topAnchor.constraint(equalTo: cell.topAnchor, constant: 4),
            cellImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 4),
            
            cellGradientView.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            cellGradientView.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            cellGradientView.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor),
            cellGradientView.topAnchor.constraint(equalTo: cellDataLabel.topAnchor, constant: -4),
            
            cellDataLabel.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor, constant: 8),
            cellDataLabel.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: 8),
            cellDataLabel.trailingAnchor.constraint(greaterThanOrEqualTo: cellImage.trailingAnchor, constant: 8),
            
            cellLikeButton.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            cellLikeButton.topAnchor.constraint(equalTo: cellImage.topAnchor)
        ])
    }
}
