//
//  DonutTotalView.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - DonutTotalView

@available(iOS 13.0, *)
final class DonutTotalView: UIView, IBSDesignRedrawable {
    
    // MARK: - Public structures
    
    struct Total {
        var width: CGFloat
        var offset: CGFloat
        var color: UIColor
    }
    
    
    
    // MARK: - Public properties
    
    var total: Total = .init(width: 20.0, offset: 0.0, color: .clear)
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(DonutTotalView.self) doesn't support XIB layout")
    }
    
    
    
    // MARK: - Overriding parent methods
    
    override func draw(_ rect: CGRect) {
        let topLeftOffset = total.offset + (total.width / 2.0)
        let bottomRightOffset = total.width + (total.offset * 2.0)
        
        let path = UIBezierPath(ovalIn: .init(x: topLeftOffset,
                                              y: topLeftOffset,
                                              width: rect.width - bottomRightOffset,
                                              height: rect.height - bottomRightOffset))
        
        UIColor.clear.setFill()
        total.color.setStroke()
        
        path.lineWidth = total.width
        
        path.fill()
        path.stroke()
    }
    
    
    
    // MARK: - Public methods
    
    func redraw() {
        setNeedsDisplay()
    }
    
}
