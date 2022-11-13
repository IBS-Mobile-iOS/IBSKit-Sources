//
//  DonutChartView.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - DonutChartView

@available(iOS 13.0, *)
final class DonutChartView: UIView, IBSDesignRedrawable {
    
    // MARK: - Public enumerations
    
    enum SegmentStyle: Int32, CaseIterable {
        case dashed
        case filled
        case triangled
    }
    
    enum PatternDirection: Int32, CaseIterable {
        case topLeftCorner
        case topSide
        case topRightCorner
        case leftSide
        case rightSide
        case bottomLeftCorner
        case bottomSide
        case bottomRightCorner
    }
    
    
    
    // MARK: - Public structures
    
    struct Segment {
        var style: SegmentStyle
        var value: CGFloat
        var color: UIColor
        
        init(style: SegmentStyle = .filled,
             value: CGFloat,
             color: UIColor = .clear) {
            self.style = style
            self.value = value
            self.color = color
        }
    }
    
    struct Pattern {
        var size: CGFloat
        var repeatsCount: CGFloat
        var direction: PatternDirection
        
        init(size: CGFloat,
             repeatsCount: CGFloat,
             direction: PatternDirection = .topSide) {
            self.size = size
            self.repeatsCount = repeatsCount
            self.direction = direction
        }
    }
    
    
    
    // MARK: - Private structures
    
    private struct Angle {
        var start: CGFloat
        var end: CGFloat
    }
    
    private struct PrecalculatedPie {
        var angle: Angle
        var segment: Segment
    }
    
    
    
    // MARK: - Public properties
    
    var width: CGFloat = 10.0
    
    var cap: CGLineCap = .butt
    
    var pies: [Segment] = []
    
    var pattern: Pattern = .init(size: 10.0, repeatsCount: 5.0) {
        willSet {
            DonutChartView.patternSize = newValue.size
        }
    }
    
    
    
    // MARK: - Static properties
    
    private static var patternSize: CGFloat = 0.0
    
    
    
    // MARK: - Private properties
    
    private lazy var dashPatternCallback: CGPatternDrawPatternCallback = { _, context in
        let linePath = CGMutablePath()
        
        let topleft = CGPoint(x: 0.0, y: 0.0)
        
        let topRight = CGPoint(x: DonutChartView.patternSize, y: 0.0)
        
        let bottomRight = CGPoint(x: DonutChartView.patternSize,
                                  y: DonutChartView.patternSize * 100.0)
        
        let bottomLeft = CGPoint(x: 0.0, y: DonutChartView.patternSize * 100.0)
        
        linePath.addLines(between: [topleft, topRight, bottomRight, bottomLeft])
        linePath.closeSubpath()
        
        context.addPath(linePath)
        context.fillPath()
    }
    
    // Triangle Pattern Callback
    private lazy var trianglePatternCallback: CGPatternDrawPatternCallback = { _, context in
        let trianglePath = CGMutablePath()
        
        let top = CGPoint(x: DonutChartView.patternSize / 2.0, y: 0.0)
        
        let bottomLeft = CGPoint(x: 0.0, y: DonutChartView.patternSize)
        
        let bottomRight = CGPoint(x: DonutChartView.patternSize,
                                  y: DonutChartView.patternSize)
        
        trianglePath.addLines(between: [top, bottomLeft, bottomRight])
        trianglePath.closeSubpath()
        
        context.addPath(trianglePath)
        context.fillPath()
    }
    
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("\(DonutChartView.self) doesn't support XIB layout")
    }
    
    
    
    // MARK: - Overriding parent methods
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let radius = (min(rect.width, rect.height) - width) * 0.5
        
        let center = CGPoint(x: rect.midX,
                             y: rect.midY)
        
        let count = pies.reduce(0) { $0 + $1.value }
        
        var angle = Angle(start: -.pi * 0.5, end: 0.0)
        
        var precalculatedPies: [PrecalculatedPie] = []
        
        pies.forEach { pie in
            angle.end = ((pie.value / count) * .pi * 2.0) + angle.start
            
            precalculatedPies.append(.init(angle: .init(start: angle.start,
                                                        end: angle.end),
                                           segment: pie))
            
            angle.start = angle.end
        }
        
        precalculatedPies.reversed().forEach { precalculatedPie in
            context.setLineWidth(width)
            
            context.setLineCap(cap)
            
            context.setStrokeColor(precalculatedPie.segment.color.cgColor)
            
            context.addArc(center: center,
                           radius: radius,
                           startAngle: precalculatedPie.angle.start,
                           endAngle: precalculatedPie.angle.end,
                           clockwise: false)
            
            drawPattern(context,
                        rect,
                        precalculatedPie.segment.style,
                        precalculatedPie.segment.color.cgColor.components!)
            
            context.strokePath()
        }
    }
    
    
    
    // MARK: - Public methods
    
    func redraw() {
        setNeedsDisplay()
    }
    
    
    
    // MARK: - Private functions
    
    private func drawPattern(_ context: CGContext, _ rect: CGRect, _ style: SegmentStyle, _ color: [CGFloat]) {
        var callbacks = CGPatternCallbacks()
        
        switch style {
        case .dashed:
            callbacks = .init(version: 0,
                              drawPattern: dashPatternCallback,
                              releaseInfo: nil)
        case .filled:
            return
        case .triangled:
            callbacks = .init(version: 0,
                              drawPattern: trianglePatternCallback,
                              releaseInfo: nil)
        }
        
        let patternStepX = rect.width / pattern.repeatsCount
        let patternStepY = rect.height / pattern.repeatsCount
        
        let patternOffsetX = (patternStepX - pattern.size) / 2.0
        let patternOffsetY = (patternStepY - pattern.size) / 2.0
        
        var transform: CGAffineTransform
        
        switch pattern.direction {
        case .topLeftCorner:
            transform = .init(rotationAngle: -0.25 * .pi)
        case .topSide:
            transform = .identity
        case .topRightCorner:
            transform = .init(rotationAngle: 0.25 * .pi)
        case .leftSide:
            transform = .init(rotationAngle: -0.5 * .pi)
        case .rightSide:
            transform = .init(rotationAngle: 0.5 * .pi)
        case .bottomLeftCorner:
            transform = .init(rotationAngle: -0.75 * .pi)
        case .bottomSide:
            transform = .init(rotationAngle: .pi)
        case .bottomRightCorner:
            transform = .init(rotationAngle: 0.75 * .pi)
        }
        
        transform = transform
            .translatedBy(x: patternOffsetX, y: patternOffsetY)
        
        guard
            let pattern = CGPattern(info: nil,
                                    bounds: .init(x: 0.0,
                                                  y: 0.0,
                                                  width: pattern.size,
                                                  height: pattern.size),
                                    matrix: transform,
                                    xStep: patternStepX,
                                    yStep: patternStepY,
                                    tiling: .constantSpacing,
                                    isColored: false,
                                    callbacks: &callbacks)
        else { return }
        
        let deviceColorSpace = CGColorSpaceCreateDeviceRGB()
        
        guard
            let patternColorSpace = CGColorSpace(patternBaseSpace: deviceColorSpace)
        else { return }
        
        context.setStrokeColorSpace(patternColorSpace)
        context.setStrokePattern(pattern, colorComponents: color)
    }    
}
