//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 17.02.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    // MARK: Properties
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
        }
    }
    
    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        imageView.image = image
    }
}
