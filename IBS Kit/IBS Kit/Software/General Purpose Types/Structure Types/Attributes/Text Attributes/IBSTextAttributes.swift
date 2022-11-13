//
//  IBSTextAttributes.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSTextAttributes

///
///
///
@available(iOS 13.0, *)
public struct IBSTextAttributes {

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
    public  var font: UIFont
    
    ///
    ///
    ///
    public var shadow: IBSShadowStyle

    ///
    ///
    ///
    public init(text: String = "",
         color: UIColor = .clear,
         font: UIFont = .systemFont(ofSize: 0),
         shadow: IBSShadowStyle = .init()) {
        self.text = text
        self.color = color
        self.font = font
        self.shadow = shadow
    }
}
