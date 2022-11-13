//
//  BlurVisualFXLayer.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import QuartzCore



// MARK: - BlurVisualFXLayer

@available(iOS 13.0, *)
final class BlurVisualFXLayer: CALayer {

    // MARK: - Public properties

    @NSManaged var intensity: CGFloat


    
    // MARK: - Init

    override init(layer: Any) {
        super.init(layer: layer)

        guard let layer = layer as? BlurVisualFXLayer else { return }

        intensity = layer.intensity
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("\(BlurVisualFXLayer.self) doesn't support XIB layout")
    }



    // MARK: - Overriding parent methods

    override class func needsDisplay(forKey key: String) -> Bool {
        key == #keyPath(intensity) ? true : super.needsDisplay(forKey: key)
    }

    override func action(forKey event: String) -> CAAction? {
        guard event == #keyPath(intensity) else { return super.action(forKey: event) }

        let animation = CABasicAnimation(keyPath: event)
        animation.fromValue = (presentation() ?? self).intensity
        animation.toValue = nil

        return animation
    }
}
