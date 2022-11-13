//
//  IBSBlurVisualFX.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSBlurVisualFX

///
///
///
@available(iOS 13.0, *)
public class IBSBlurVisualFX: UIView {
    
    // MARK: - Public properties
    
    ///
    ///
    ///
    override public class var layerClass: AnyClass { BlurVisualFXLayer.self }
    
    ///
    ///
    ///
    public var intensity: CGFloat = 0.0 {
        willSet {
            (layer as! BlurVisualFXLayer).intensity = newValue
        }
    }
    
    ///
    ///
    ///
    public var style: UIBlurEffect.Style = .regular {
        willSet {
            setupPropertyAnimator()
        }
    }
    
    
    
    // MARK: - Private properties
    
    private let visualEffectView = UIVisualEffectView(effect: nil)
    
    private var propertyAnimator: UIViewPropertyAnimator!
    
    private var blurVisualFXLayer: BlurVisualFXLayer { layer as! BlurVisualFXLayer }
    
    
    
    // MARK: - Init
    
    ///
    ///
    ///
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRootView()
        setupViews()
        
        setupPropertyAnimator()
        
        computeFrames()
    }
    
    ///
    ///
    ///
    public required init?(coder: NSCoder) {
        fatalError("\(IBSBlurVisualFX.self) doesn't support XIB layout")
    }
    
    
    
    // MARK: - Overriding parent methods
    
    ///
    ///
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        computeFrames()
    }
    
    ///
    ///
    ///
    public override func display(_ layer: CALayer) {
        guard let presentationLayer = layer.presentation() as? BlurVisualFXLayer else { return }
        
        let clampedIntensity = max(0.0, min(1.0, presentationLayer.intensity))
        
        propertyAnimator.fractionComplete = clampedIntensity
    }
    
    
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    public func addSubview(to contentView: UIView) {
        visualEffectView.contentView.addSubview(contentView)
    }
    
    
    
    // MARK: - Private functions
    
    private func setupPropertyAnimator() {
        propertyAnimator?.stopAnimation(true)
        
        propertyAnimator = UIViewPropertyAnimator(duration: 1.0,
                                                  curve: .linear)
        
        propertyAnimator.addAnimations { [weak self] in
            guard let self else { return }
            
            self.visualEffectView.effect = UIBlurEffect(style: self.style)
        }
        
        propertyAnimator.pausesOnCompletion = true
    }
    
    
    
    // MARK: - Deinit
    
    deinit {
        propertyAnimator.stopAnimation(true)
    }
}



// MARK: - IBSDesignDrawable

@available(iOS 13.0, *)
extension IBSBlurVisualFX: IBSDesignDrawable {
    
    // MARK: - Public methods
    
    func setupRootView() {
        backgroundColor = .clear
    }
    
    func setupViews() {
        addSubview(self.visualEffectView)
    }
    
    func computeFrames() {
        visualEffectView.frame = bounds
    }
}
