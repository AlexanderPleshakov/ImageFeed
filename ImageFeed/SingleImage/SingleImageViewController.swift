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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private weak var backwardButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        imageView.image = image
        imageView.frame.size = image?.size ?? CGSize(width: 0, height: 0)
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
    }
    
    // MARK: Actions
    
    @IBAction func buttonBackwardTapped() {
        dismiss(animated: true)
    }
}

// MARK: UIScrollViewDelegate

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
