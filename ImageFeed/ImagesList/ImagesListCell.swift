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
    
    @IBOutlet weak var cellGradientView: UIView!
    @IBOutlet weak var cellDataLabel: UILabel!
    @IBOutlet weak var cellLikeButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    
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
        guard let likeImage = indexPath.row % 2 != 0 ? UIImage(named: "FavoritesNoActive") : UIImage(named: "FavoritesActive"),
              let mainImage = UIImage(named: "\(ImagesListCell.photosName[indexPath.row])")
        else { return }
        
        cell.doGradient(for: cell.cellGradientView)
        cell.cellImage.image = mainImage
        cell.cellDataLabel.text = dateFormatter.string(from: Date())
        cell.cellLikeButton.setImage(likeImage, for: .normal)
    }
}
