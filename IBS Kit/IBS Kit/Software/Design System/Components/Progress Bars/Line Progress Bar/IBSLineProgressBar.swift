//
//  IBSLineProgressBar.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSLineProgressBar

///
///
///
@available(iOS 13.0, *)
final class IBSLineProgressBar: UIView {

    // MARK: - Public properties

    // Cap
        public var cap: CapStyle = .butt {
            willSet {
                
            }
        }
    
    ///
    ///
    ///
    public var colors: Colors = .init() {
        willSet {
            
        }
    }

    // Width
    public var width: CGFloat = 10.0 {
        willSet {
            
        }
    }

    // Offset
    public var offset: CGFloat = 0.0 {
        willSet {
            
        }
    }
    


    // MARK: - Init

    public override init(frame: CGRect) {
        super.init(frame: frame)

        computeFrames()
    }

    public required init?(coder: NSCoder) {
        fatalError("\(IBSLineProgressBar.self) doesn't support XIB layout")
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
    
    private func update(for status: IBSProgressBarSyncStatus, with progress: CGFloat) {
        // add some logic
    }
}



// MARK: - IBSDesignDrawable

extension IBSLineProgressBar: IBSDesignDrawable {
    
    // MARK: - Public methods
    
    func setupRootView() { }
    
    func setupViews() { }
    
    func makeLayout() { }
    
    func computeFrames() { }
}



// MARK: - IBSProgressBarUpdatable

extension IBSLineProgressBar: IBSProgressBarUpdatable {
    
    // MARK: - Public methods
    
    ///
    ///
    ///
    public func update(progress: Float, with status: IBSProgressBarSyncStatus) {
        update(for: status, with: .init(progress))
    }
    
    ///
    ///
    ///
    public func update(progress: Double, with status: IBSProgressBarSyncStatus) {
        update(for: status, with: .init(progress))
    }
}
