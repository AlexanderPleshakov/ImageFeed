//
//  GradientView.swift
//  ImageFeed
//
//  Created by Александр Плешаков on 01.04.2024.
//

import UIKit

final class GradientView: UIView {
    private var gradientLayer: CAGradientLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
    }
    
    init() {
        super.init(frame: .zero)
        
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        let ypColor20 = UIColor(named: "YP Black")?.withAlphaComponent(0.4).cgColor
        let ypColor15 = UIColor(named: "YP Black")?.withAlphaComponent(0.25).cgColor
        gradientLayer.colors = [ypColor20 ?? UIColor.black.withAlphaComponent(0.2).cgColor,
                                    ypColor15 ?? UIColor.black.withAlphaComponent(0.15).cgColor,
                                    UIColor.clear.cgColor]
        gradientLayer.locations = [0, 0.5, 1]
        
        layer.mask = gradientLayer
        self.gradientLayer = gradientLayer
    }
}
