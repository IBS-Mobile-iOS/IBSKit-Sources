//
//  IBSIndentedLabel.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSIndentedLabel

///
///
///
@available(iOS 13.0, *)
public final class IBSIndentedLabel: UILabel {

    // MARK: - Public properties

    ///
    ///
    ///
    public var padding: IBSPadding = .init() {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }



    // MARK: - Overriding parent methods

    ///
    ///
    ///
    public override func textRect(forBounds bounds: CGRect,
                                  limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let textEdgeInsets = UIEdgeInsets(
            top: padding.top,
            left: padding.left,
            bottom: padding.bottom,
            right: padding.right
        )

        let insetRect = bounds.inset(by: textEdgeInsets)

        let textRect = super.textRect(
            forBounds: insetRect,
            limitedToNumberOfLines: numberOfLines
        )

        let invertedInsets = UIEdgeInsets(
            top: -textEdgeInsets.top,
            left: -textEdgeInsets.left,
            bottom: -textEdgeInsets.bottom,
            right: -textEdgeInsets.right
        )

        return textRect.inset(by: invertedInsets)
    }

    ///
    ///
    ///
    public override func drawText(in rect: CGRect) {
        let textEdgeInsets = UIEdgeInsets(
            top: padding.top,
            left: padding.left,
            bottom: padding.bottom,
            right: padding.right
        )

        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
}
