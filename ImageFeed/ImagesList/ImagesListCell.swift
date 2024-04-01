//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 08.02.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
        self.setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Properties
    
    static let reuseIdentifier = "ImageListCell"
    static let photosName = Array(0..<20).map { "\($0)" }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    private let cellGradientView: GradientView = {
        let view = GradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "YP Black")
        view.layer.masksToBounds = true
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
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(named: "YP Black")
        return imageView
    }()
    
    //MARK: Functions
    
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        setupSubviews()
        setConstraints()
        
        guard let likeImage = indexPath.row % 2 != 0 ? UIImage(named: "FavoritesNoActive") : UIImage(named: "FavoritesActive"),
              let mainImage = UIImage(named: "\(ImagesListCell.photosName[indexPath.row])")
        else { return }
        
        cell.cellImage.image = mainImage
        cell.cellDataLabel.text = dateFormatter.string(from: Date())
        cell.cellLikeButton.setImage(likeImage, for: .normal)
    }
    
    private func setupSubviews() {
        addSubview(cellImage)
        addSubview(cellGradientView)
        addSubview(cellDataLabel)
        addSubview(cellLikeButton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cellImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            cellGradientView.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor),
            cellGradientView.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            cellGradientView.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor),
            cellGradientView.topAnchor.constraint(equalTo: cellDataLabel.topAnchor, constant: -4),
            
            cellDataLabel.leadingAnchor.constraint(equalTo: cellImage.leadingAnchor, constant: 8),
            cellDataLabel.bottomAnchor.constraint(equalTo: cellImage.bottomAnchor, constant: -8),
            cellDataLabel.trailingAnchor.constraint(greaterThanOrEqualTo: cellImage.trailingAnchor, constant: 8),
            
            cellLikeButton.trailingAnchor.constraint(equalTo: cellImage.trailingAnchor),
            cellLikeButton.topAnchor.constraint(equalTo: cellImage.topAnchor)
        ])
    }
}
