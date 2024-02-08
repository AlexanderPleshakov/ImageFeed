//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 08.02.2024.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImageListCell"
    
    @IBOutlet weak var cellDataLabel: UILabel!
    @IBOutlet var cellLikeButton: UIButton!
    @IBOutlet var cellImage: UIImageView!
    
    
}
