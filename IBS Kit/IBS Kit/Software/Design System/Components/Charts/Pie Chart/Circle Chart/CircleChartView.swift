//
//  CircleChartView.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: - Import section

import UIKit




// MARK: - CircleChartView

@available(iOS 13.0, *)
final class CircleChartView: UIView {

    // MARK: - Public enumerations

    enum SegmentStyle: Int32 {
        case dashed
        case filled
        case triangled
    }

    enum PatternDirection: Int32 {
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



    // MARK: - Public properties

    var pies: [Segment] = []

    var pattern: Pattern = .init(size: 10.0, repeatsCount: 5.0) {
        willSet {
            CircleChartView.patternSize = newValue.size
        }
    }



    // MARK: - Private properties

    private static var patternSize: CGFloat = 0.0

    private lazy var dashPatternCallback: CGPatternDrawPatternCallback = { _, context in
        let linePath = CGMutablePath()

        let topleft = CGPoint(x: 0.0, y: 0.0)

        let topRight = CGPoint(x: CircleChartView.patternSize, y: 0.0)

        let bottomRight = CGPoint(x: CircleChartView.patternSize,
                                  y: CircleChartView.patternSize * 100.0)

        let bottomLeft = CGPoint(x: 0.0, y: CircleChartView.patternSize * 100.0)

        linePath.addLines(between: [topleft, topRight, bottomRight, bottomLeft])
        linePath.closeSubpath()

        context.addPath(linePath)
        context.fillPath()
    }

    private lazy var trianglePatternCallback: CGPatternDrawPatternCallback = { _, context in
        let trianglePath = CGMutablePath()

        let top = CGPoint(x: CircleChartView.patternSize / 2.0, y: 0.0)

        let bottomLeft = CGPoint(x: 0.0, y: CircleChartView.patternSize)

        let bottomRight = CGPoint(x: CircleChartView.patternSize,
                                  y: CircleChartView.patternSize)

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
        fatalError("\(String(describing: CircleChartView.self)) doesn't support XIB layout")
    }



    // MARK: - Overriding parent methods

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        let radius = min(frame.size.width, frame.size.height) * 0.5

        let center = CGPoint(x: bounds.size.width * 0.5,
                             y: bounds.size.height * 0.5)

        let count = pies.reduce(0) { $0 + $1.value }

        var angle = Angle(start: -.pi * 0.5, end: 0.0)

        self.pies.forEach { pie in
            angle.end = ((pie.value / count) * .pi * 2.0) + angle.start

            context.setFillColor(pie.color.cgColor)

            context.move(to: center)

            context.addArc(center: center,
                           radius: radius,
                           startAngle: angle.start,
                           endAngle: angle.end,
                           clockwise: false)

            drawPattern(context, rect, pie.style, pie.color.cgColor.components!)

            context.fillPath()

            angle.start = angle.end
        }
    }



    // MARK: - Private functions

    private func drawPattern(_ context: CGContext, _ rect: CGRect, _ style: SegmentStyle, _ color: [CGFloat]) {
        var callbacks = CGPatternCallbacks()

        switch style {
        case .dashed:
            callbacks = CGPatternCallbacks(version: 0,
                                           drawPattern: self.dashPatternCallback,
                                           releaseInfo: nil)
        case .filled:
            return
        case .triangled:
            callbacks = CGPatternCallbacks(version: 0,
                                           drawPattern: self.trianglePatternCallback,
                                           releaseInfo: nil)
        }

        let patternStepX = rect.width / self.pattern.repeatsCount
        let patternStepY = rect.height / self.pattern.repeatsCount

        let patternOffsetX = (patternStepX - self.pattern.size) / 2.0
        let patternOffsetY = (patternStepY - self.pattern.size) / 2.0

        var transform: CGAffineTransform

        switch self.pattern.direction {
        case .topLeftCorner:
            transform = CGAffineTransform(rotationAngle: -0.25 * .pi)
        case .topSide:
            transform = .identity
        case .topRightCorner:
            transform = CGAffineTransform(rotationAngle: 0.25 * .pi)
        case .leftSide:
            transform = CGAffineTransform(rotationAngle: -0.5 * .pi)
        case .rightSide:
            transform = CGAffineTransform(rotationAngle: 0.5 * .pi)
        case .bottomLeftCorner:
            transform = CGAffineTransform(rotationAngle: -0.75 * .pi)
        case .bottomSide:
            transform = CGAffineTransform(rotationAngle: .pi)
        case .bottomRightCorner:
            transform = CGAffineTransform(rotationAngle: 0.75 * .pi)
        }

        transform = transform.translatedBy(x: patternOffsetX, y: patternOffsetY)

        guard
            let pattern = CGPattern(info: nil,
                                    bounds: CGRect(x: 0.0,
                                                   y: 0.0,
                                                   width: self.pattern.size,
                                                   height: self.pattern.size),
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

        context.setFillColorSpace(patternColorSpace)
        context.setFillPattern(pattern, colorComponents: color)
    }
}
