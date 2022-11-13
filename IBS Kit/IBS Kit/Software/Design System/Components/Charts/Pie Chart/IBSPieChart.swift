//
//  IBSPieChart.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: - Import section

import UIKit




// MARK: - IBSPieChart

///
///
///
@available(iOS 13.0, *)
public final class IBSPieChart: UIView {
    
    // MARK: - Public properties

    ///
    ///
    ///
    public var total: Total = .init(value: 0.0) {
        willSet {
            totalView.backgroundColor = newValue.color
        }
    }

    ///
    ///
    ///
    public var segments: [Segment] = [] {
        willSet {
            circleChartView.isHidden = (newValue.isEmpty || newValue.reduce(0, { $0 + $1.value }).isEqual(to: 0.0))
        }
    }

    ///
    ///
    ///
    public var pattern: Pattern = .init(size: 1.0, repeatsCount: 3) {
        willSet {
            circleChartView.pattern = .init(
                size: newValue.size,
                repeatsCount: newValue.repeatsCount,
                direction: .init(rawValue: newValue.direction.rawValue) ?? .topLeftCorner
            )
        }
    }

    ///
    ///
    ///
    public var textAttributes: IBSTextAttributes = .init() {
        willSet {
            label.text = newValue.text
            label.textColor = newValue.color
            label.font = newValue.font
            label.layer.shadowColor = newValue.shadowStyle.color
            label.layer.shadowOffset = newValue.shadowStyle.offset
            label.layer.shadowRadius = newValue.shadowStyle.radius
            label.layer.shadowOpacity = newValue.shadowStyle.opacity
        }
    }



    // MARK: - Private properties

    private let totalView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let circleChartView: CircleChartView = {
        let circleChartView = CircleChartView()
        circleChartView.isUserInteractionEnabled = false
        circleChartView.clipsToBounds = true
        circleChartView.translatesAutoresizingMaskIntoConstraints = false
        return circleChartView
    }()

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
        fatalError("\(String(describing: IBSPieChart.self)) doesn't support XIB layout")
    }



    // MARK: - Overriding parent methods

    ///
    ///
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()

        computeFrames()

        computeCornerRadius(for: totalView, with: 2.0)
    }



    // MARK: - Private functions

    private func setupViews() {
        addSubview(totalView)
        addSubview(circleChartView)
        addSubview(label)
    }

    private func computeFrames() {
        totalView.frame = CGRect(
            x: total.offset,
            y: total.offset,
            width: bounds.width - (total.offset * 2.0),
            height: bounds.height - (total.offset * 2.0)
        )

        circleChartView.frame = bounds

        label.frame = bounds
    }

    private func computeCornerRadius(for view: UIView, with multiplier: CGFloat) {
        if view.bounds.width > view.bounds.height {
            view.layer.cornerRadius = view.bounds.height / multiplier
        } else {
            view.layer.cornerRadius = view.bounds.width / multiplier
        }
    }
}



// MARK: - IBSDesignRedrawable

extension IBSPieChart {

    // MARK: - Public methods

    ///
    ///
    ///
    public func redraw() {
        guard !segments.isEmpty else { return }

        let segmentsSum = segments.reduce(0, { $0 + $1.value })

        guard !segmentsSum.isEqual(to: 0.0) else { return }

        let totalValue = (total.value - segmentsSum).isLess(than: 0) ? 0 : total.value - segmentsSum

        circleChartView.pies.removeAll()

        segments.forEach { segment in
            circleChartView.pies.append(
                .init(style: .init(rawValue: segment.style.rawValue) ?? .filled,
                      value: segment.value,
                      color: segment.color)
            )
        }

        circleChartView.pies.append(
            .init(style: .filled,
                  value: totalValue,
                  color: .clear)
        )

        circleChartView.redraw()
    }
}
