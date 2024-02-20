//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 17.02.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    // MARK: Properties
    
    var image: UIImage! {
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
        imageView.frame.size = image.size
        
        configurateFor(imageSize: image.size)
    }
    
    func configurateFor(imageSize: CGSize) {
        scrollView.bounds.size = view.bounds.size
        scrollView.contentSize = imageSize
        
        setCurrentMaxAndMinZoomScale()
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    func setCurrentMaxAndMinZoomScale() {
        let boundsSize = scrollView.bounds.size
        let imageSize = imageView.bounds.size
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 2.0
        if minScale < 0.1 {
            maxScale = 0.3
        }
        if minScale >= 0.1 && minScale < 0.5 {
            maxScale = 0.7
        }
        if minScale >= 0.5 {
            maxScale = max(4, minScale)
        }
        if minScale >= 2 {
            maxScale = max(5, minScale)
        }
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
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
