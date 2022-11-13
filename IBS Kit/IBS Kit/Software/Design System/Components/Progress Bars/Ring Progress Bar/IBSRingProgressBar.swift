//
//  IBSRingProgressBar.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSRingProgressBar

///
///
///
@available(iOS 13.0, *)
public final class IBSRingProgressBar: UIView {

    // MARK: - Public enumerations

    ///
    ///
    ///
    public enum CapStyle: String, CaseIterable {
        case butt = "Butt cap"
        case round = "Round cap"
    }



    // MARK: - Public structures

    ///
    ///
    ///
    public struct Colors {

        ///
        ///
        ///
        public var ring: UIColor
        
        ///
        ///
        ///
        public var progress: UIColor
        
        ///
        ///
        ///
        public init(ring: UIColor = .clear,
                    progress: UIColor = .clear) {
            self.ring = ring
            self.progress = progress
        }

    }



    // MARK: - Public properties

    ///
    ///
    ///
    public var colors: Colors = .init() {
        willSet {
            donutChartView.total.color = newValue.ring
            donutChartView.segments[0].color = newValue.progress
            donutChartView.redraw()
        }
    }

    ///
    ///
    ///
    public var width: CGFloat = 10.0 {
        willSet {
            donutChartView.width = newValue
            donutChartView.redraw()
        }
    }

    ///
    ///
    ///
    public var offset: CGFloat = 0.0 {
        willSet {
            donutChartView.total = .init(
                value: 1.0,
                color: donutChartView.total.color,
                offset: newValue
            )
            donutChartView.redraw()
        }
    }

    ///
    ///
    ///
    public var cap: CapStyle = .butt {
        willSet {
            donutChartView.cap = .init(rawValue: newValue.rawValue) ?? .butt
            donutChartView.redraw()
        }
    }



    // MARK: - Private properties

    private let donutChartView: IBSDonutChart = {
        let donutChartView = IBSDonutChart()
        donutChartView.total = .init(value: 1.0)
        donutChartView.segments.append(.init(value: 0.0))
        donutChartView.redraw()
        donutChartView.isUserInteractionEnabled = false
        donutChartView.clipsToBounds = true
        donutChartView.translatesAutoresizingMaskIntoConstraints = false
        return donutChartView
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

    public required init?(coder: NSCoder) {
        fatalError("\(IBSRingProgressBar.self) doesn't support XIB layout")
    }



    // MARK: - Overriding parent methods

    ///
    ///
    ///
    public override func layoutSubviews() {
        super.layoutSubviews()

        self.computeFrames()

    }



    // MARK: - Private functions

    private func setupViews() {
        addSubview(donutChartView)
    }

    private func computeFrames() {
        donutChartView.frame = bounds
    }

    private func update(for status: IBSProgressBarSyncStatus, with progress: CGFloat) {
        donutChartView.segments[0].value = progress
        
        donutChartView.redraw()
    }
}



// MARK: - IBSProgressBarUpdatable

extension IBSRingProgressBar: IBSProgressBarUpdatable {
    
    ///
    ///
    ///
    public func update(progress: Float, with status: IBSProgressBarSyncStatus) {
        
    }
    
    ///
    ///
    ///
public func update(progress: Double, with status: IBSProgressBarSyncStatus) {
        update(for: status, with: CGFloat(progress))
    }
}
