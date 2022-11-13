//
//  IBSVibrancyVisualFX.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSVibrancyVisualFX

///
///
///
@available(iOS 13.0, *)
public class IBSVibrancyVisualFX: UIView {
    
    // MARK: - Public properties

    ///
    ///
    ///
    public var intensity: CGFloat = 0.0 {
        willSet {
            blurVisualFX.intensity = newValue
        }
    }

    ///
    ///
    ///
    public var style: Style = .init(blur: .regular, vibrancy: .label) {
        willSet {
            blurVisualFX.style = newValue.blur
            
            let blurEffect = UIBlurEffect(style: newValue.blur)
            
            vibrancyVisualFX.effect = UIVibrancyEffect(
                blurEffect: blurEffect,
                style: newValue.vibrancy
            )
        }
    }



    // MARK: - Private properties

    private let blurVisualFX: IBSBlurVisualFX = {
        let view = IBSBlurVisualFX()
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let vibrancyVisualFX: UIVisualEffectView = {
        let view = UIVisualEffectView()
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()



    // MARK: - Init

    ///
    ///
    ///
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

        makeLayout()
    }

    ///
    ///
    ///
    public required init?(coder: NSCoder) {
        fatalError("\(IBSVibrancyVisualFX.self) doesn't support XIB layout")
    }



    // MARK: - Public methods

    ///
    ///
    ///
    public func fillContentView(with subview: UIView) {
        vibrancyVisualFX.contentView.addSubview(subview)
    }

    ///
    ///
    ///
    public func fillContentView(with subviews: [UIView]) {
        subviews.forEach { subview in
            vibrancyVisualFX.contentView.addSubview(subview)
        }
    }
}



// MARK: - IBSDesignDrawable

@available(iOS 13.0, *)
extension IBSVibrancyVisualFX: IBSDesignDrawable {
    
    // MARK: - Public methods
    
    func setupRootView() {
        backgroundColor = .clear
    }
    
    func setupViews() {
        addSubview(blurVisualFX)
        
        blurVisualFX.addSubview(to: vibrancyVisualFX)
    }
    
    func makeLayout() {
        NSLayoutConstraint.activate([
            blurVisualFX.topAnchor.constraint(equalTo: topAnchor),
            blurVisualFX.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurVisualFX.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurVisualFX.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            vibrancyVisualFX.topAnchor.constraint(equalTo: vibrancyVisualFX.topAnchor),
            vibrancyVisualFX.leadingAnchor.constraint(equalTo: blurVisualFX.leadingAnchor),
            vibrancyVisualFX.trailingAnchor.constraint(equalTo: blurVisualFX.trailingAnchor),
            vibrancyVisualFX.bottomAnchor.constraint(equalTo: blurVisualFX.bottomAnchor)
        ])
    }
}
