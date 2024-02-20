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
    
//    lazy var zoomingTap: UITapGestureRecognizer = {
//        let zoomingTap = UITapGestureRecognizer(target: scrollView, action: #selector(handleZoomingTap))
//        zoomingTap.numberOfTapsRequired = 2
//        return zoomingTap
//    }()
    
    // MARK: Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var backwardButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        imageView.frame.size = image.size
        
        configurateFor(imageSize: image.size)
    }
    
    override func viewWillLayoutSubviews() {
        centerImage()
    }
    
    // MARK: Methods
    
    private func configurateFor(imageSize: CGSize) {
        scrollView.bounds.size = view.bounds.size
        scrollView.contentSize = imageSize
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        setCurrentMaxAndMinZoomScale()
        scrollView.zoomScale = scrollView.minimumZoomScale
        
//        imageView.addGestureRecognizer(zoomingTap)
//        imageView.isUserInteractionEnabled = true
    }
    
    private func setCurrentMaxAndMinZoomScale() {
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
    
    private func centerImage() {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = imageView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        imageView.frame = frameToCenter
    }
    
    // MARK: Actions
    
    @IBAction private func buttonBackwardTapped() {
        dismiss(animated: true)
    }
}

// MARK: UIScrollViewDelegate

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}

