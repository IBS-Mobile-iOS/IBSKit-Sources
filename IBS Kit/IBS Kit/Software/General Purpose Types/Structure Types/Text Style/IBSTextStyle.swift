//
//  IBSTextStyle.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSTextStyle

///
///
///
@available(iOS 13.0, *)
public struct IBSTextStyle {

    ///
    ///
    ///
    var text: String

    ///
    ///
    ///
    var color: UIColor

    ///
    ///
    ///
    var font: UIFont

    ///
    ///
    ///
    init(text: String = "",
         color: UIColor = .clear,
         font: UIFont = .systemFont(ofSize: 0)) {
        self.text = text
        self.color = color
        self.font = font
    }
}
