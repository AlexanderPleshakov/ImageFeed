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
    
    lazy var zoomingTap: UITapGestureRecognizer = {
        let zoomingTap = UITapGestureRecognizer(target: self, action: #selector(handleZoomingTap))
        zoomingTap.numberOfTapsRequired = 2
        return zoomingTap
    }()
    
    private var scrollView: UIScrollView!
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "YP Black")
        return imageView
    }()
    
    private let backwardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ShareButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configScrollView()
        view.backgroundColor = UIColor(named: "YP Black")
        
        shareButton.addTarget(self, action: #selector(buttonShareTapped), for: .touchUpInside)
        backwardButton.addTarget(self, action: #selector(buttonBackwardTapped), for: .touchUpInside)
        
        setupViews()
        
        imageView.image = image
        imageView.frame.size = image.size
        
        configurateFor(imageSize: image.size)
    }
    
    override func viewWillLayoutSubviews() {
        centerImage()
    }
    
    // MARK: Methods
    
    private func configScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor(named: "YP Black")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
    }
    
    private func configurateFor(imageSize: CGSize) {
        scrollView.bounds.size = view.bounds.size
        scrollView.contentSize = imageSize
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        setCurrentMaxAndMinZoomScale()
        scrollView.zoomScale = scrollView.minimumZoomScale
        
        imageView.addGestureRecognizer(zoomingTap)
        imageView.isUserInteractionEnabled = true
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
    
    // MARK: Gesture
        
    func zoom(point: CGPoint, animated: Bool) {
        let currentScale = scrollView.zoomScale
        let minScale = scrollView.minimumZoomScale
        let maxScale = scrollView.maximumZoomScale
        
        if (minScale == maxScale && minScale > 5) {
            return
        }
        
        let toScale = maxScale
        let finalScale = (currentScale == minScale) ? toScale : minScale
        let zoomRect = zoomRect(scale: finalScale, center: point)
        scrollView.zoom(to: zoomRect, animated: animated)
    }
    
    func zoomRect(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = scrollView.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        
        return zoomRect
    }
    
    @objc func handleZoomingTap(sender: UITapGestureRecognizer) {
        let location = sender.location(in: sender.view)
        zoom(point: location, animated: true)
    }
    
    // MARK: Actions
    
    @objc private func buttonBackwardTapped() {
        dismiss(animated: true)
    }
    
    @objc private func buttonShareTapped() {
        guard let image = image else { return }
        let activityView = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityView, animated: true)
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

extension SingleImageViewController {
    private func setupViews() {
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        view.addSubview(shareButton)
        view.addSubview(backwardButton)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            shareButton.heightAnchor.constraint(equalToConstant: 51),
            shareButton.widthAnchor.constraint(equalToConstant: 51),
            
            backwardButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            backwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 9),
            backwardButton.heightAnchor.constraint(equalToConstant: 48),
            backwardButton.widthAnchor.constraint(equalToConstant: 48)
        ])
    }
}
