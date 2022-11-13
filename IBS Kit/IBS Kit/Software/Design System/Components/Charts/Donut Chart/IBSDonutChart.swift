//
//  IBSDonutChart.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSDonutChart

///
///
///
@available(iOS 13.0, *)
public final class IBSDonutChart: UIView {

    // MARK: - Public enumerations

    ///
    ///
    ///
    public enum SegmentStyle: Int32, CaseIterable {
        case dashed
        case filled
        case triangled
    }

    ///
    ///
    ///
    public enum CapStyle: String, CaseIterable {
        case butt = "Butt cap"
        case round = "Round cap"
    }

    ///
    ///
    ///
    public enum PatternDirection: Int32, CaseIterable {
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

    ///
    ///
    ///
    public struct Total {

        ///
        ///
        ///
        public var value: CGFloat

        ///
        ///
        ///
        public var color: UIColor

        ///
        ///
        ///
        public var offset: CGFloat

        ///
        ///
        ///
        public init(value: Int,
                    color: UIColor = .clear,
                    offset: CGFloat = 0.0) {
            self.value = CGFloat(value)
            self.color = color
            self.offset = offset
        }

        ///
        ///
        ///
        public init(value: Float,
                    color: UIColor = .clear,
                    offset: CGFloat = 0.0) {
            self.value = CGFloat(value)
            self.color = color
            self.offset = offset
        }
    }

    ///
    ///
    ///
    public struct Segment {

        ///
        ///
        ///
        public var style: SegmentStyle

        ///
        ///
        ///
        public var value: CGFloat

        ///
        ///
        ///
        public var color: UIColor

        ///
        ///
        ///
        public init(style: SegmentStyle = .filled,
                    value: Int,
                    color: UIColor = .clear) {
            self.style = style
            self.value = CGFloat(value)
            self.color = color
        }

        ///
        ///
        ///
        public init(style: SegmentStyle = .filled,
                    value: Float,
                    color: UIColor = .clear) {
            self.style = style
            self.value = CGFloat(value)
            self.color = color
        }
    }

    ///
    ///
    ///
    public struct Pattern {

        ///
        ///
        ///
        public var size: CGFloat

        ///
        ///
        ///
        public var repeatsCount: CGFloat

        ///
        ///
        ///
        public var direction: PatternDirection

        ///
        ///
        ///
        public init(size: CGFloat,
                    repeatsCount: UInt16,
                    direction: PatternDirection = .topSide) {
            self.size = size
            self.repeatsCount = CGFloat(repeatsCount)
            self.direction = direction
        }
    }

    ///
    ///
    ///
    public struct TextShadow {

        ///
        ///
        ///
        public var color: CGColor

        ///
        ///
        ///
        public var offset: CGSize

        ///
        ///
        ///
        public var blur: CGFloat

        ///
        ///
        ///
        public var opacity: Float

        ///
        ///
        ///
        public init(color: UIColor = .clear, offset: CGSize = .init(width: 0.0, height: 0.0), blur: CGFloat = 0.0, opacity: Float = 0.0) {
            self.color = color.cgColor
            self.offset = offset
            self.blur = blur
            self.opacity = opacity
        }
    }

    ///
    ///
    ///
    public struct TextAttributes {

        ///
        ///
        ///
        public var text: String

        ///
        ///
        ///
        public var color: UIColor

        ///
        ///
        ///
        public var font: UIFont

        ///
        ///
        ///
        public var shadow: TextShadow

        ///
        ///
        ///
        public init(text: String = "",
                    color: UIColor = .clear,
                    font: UIFont = .systemFont(ofSize: 4.0),
                    shadow: TextShadow = .init()) {
            self.text = text
            self.color = color
            self.font = font
            self.shadow = shadow
        }
    }



    // MARK: - Public properties

    ///
    ///
    ///
    public var total: Total = .init(value: 0.0)

    ///
    ///
    ///
    public var segments: [Segment] = [] {
        willSet {
            self.donutChartView.isHidden = newValue.isEmpty || newValue.reduce(0, { $0 + $1.value }).isEqual(to: 0.0)
        }
    }

    ///
    ///
    ///
    public var width: CGFloat = 10.0 {
        willSet {
            self.donutChartView.width = newValue
        }
    }

    ///
    ///
    ///
    public var cap: CapStyle = .butt {
        willSet {
            let lineCap: CGLineCap
            
            switch newValue {
            case .butt:
                lineCap = .butt
            case .round:
                lineCap = .round
            }
            
            self.donutChartView.cap = lineCap
        }
    }

    ///
    ///
    ///
    public var pattern: Pattern = .init(size: 1.0, repeatsCount: 3) {
        willSet {
            self.donutChartView.pattern = .init(
                size: newValue.size,
                repeatsCount: newValue.repeatsCount,
                direction: .init(rawValue: newValue.direction.rawValue) ?? .topLeftCorner
            )
        }
    }

    ///
    ///
    ///
    public var textAttributes: TextAttributes = .init() {
        willSet {
            self.label.text = newValue.text
            self.label.textColor = newValue.color
            self.label.font = newValue.font
            self.label.layer.shadowColor = newValue.shadow.color
            self.label.layer.shadowOffset = newValue.shadow.offset
            self.label.layer.shadowRadius = newValue.shadow.blur
            self.label.layer.shadowOpacity = newValue.shadow.opacity
        }
    }



    // MARK: - Private properties

    ///
    ///
    ///
    private let donutTotalView: DonutTotalView = {
        let donutTotalView = DonutTotalView()
        donutTotalView.isUserInteractionEnabled = false
        donutTotalView.clipsToBounds = true
        donutTotalView.translatesAutoresizingMaskIntoConstraints = false
        return donutTotalView
    }()

    ///
    ///
    ///
    private let donutChartView: DonutChartView = {
        let donutChartView = DonutChartView()
        donutChartView.isUserInteractionEnabled = false
        donutChartView.clipsToBounds = true
        donutChartView.translatesAutoresizingMaskIntoConstraints = false
        return donutChartView
    }()

    ///
    ///
    ///
    private let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.baselineAdjustment = .alignCenters
        label.numberOfLines = 1
        label.isUserInteractionEnabled = false
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()



    // MARK: - Init

    ///
    ///
    ///
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

        computeFrames()
    }

    ///
    ///
    ///
    public required init?(coder: NSCoder) {
        fatalError("\(String(describing: IBSDonutChart.self)) doesn't support XIB layout")
    }



    // MARK: - Overriding parent methods

    ///
    ///
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()

        computeFrames()
    }



    // MARK: - Private functions

    private func setupViews() {
        addSubview(donutTotalView)
        addSubview(donutChartView)
        addSubview(label)
    }

    private func computeFrames() {
        donutTotalView.frame = bounds
        donutChartView.frame = bounds
        label.frame = bounds
    }
}



// MARK: - IBSDesignRedrawable

extension IBSDonutChart {

    // MARK: - Public methods

    ///
    ///
    ///
    public func redraw() {
        donutTotalView.total = .init(
            width: width - (total.offset * 2.0),
            offset: total.offset,
            color: total.color
        )

        donutTotalView.redraw()

        guard !segments.isEmpty else { return }

        let segmentsSum = segments.reduce(0, { $0 + $1.value })

        guard !segmentsSum.isEqual(to: 0.0) else { return }

        let totalValue: CGFloat = (total.value - segmentsSum).isLess(than: 0) ? 0 : total.value - segmentsSum

        donutChartView.pies.removeAll()

        segments.forEach { segment in
            donutChartView.pies.append(
                .init(style: .init(rawValue: segment.style.rawValue) ?? .filled,
                      value: segment.value,
                      color: segment.color)
            )
        }

        donutChartView.pies.append(
            .init(style: .filled,
                  value: totalValue,
                  color: .clear)
        )

        donutChartView.redraw()
    }
}
