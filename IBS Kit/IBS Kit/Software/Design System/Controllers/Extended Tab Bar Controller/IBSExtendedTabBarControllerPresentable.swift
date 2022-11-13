//
//  IBSExtendedTabBarControllerPresentable.swift
//  IBSKit
//
//  Created by Dimka Novikov on 13.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSExtendedTabBarControllerPresentable

///
///
///
@available(iOS 13.0, *)
public protocol IBSExtendedTabBarControllerPresentable: AnyObject {

    // MARK: - Public properties

    ///
    ///
    ///
    var back: IBSExtendedTabBarController.TabStyle { get }

    ///
    ///
    ///
    var tabs: [IBSExtendedTabBarController.TabStyle] { get }

    ///
    ///
    ///
    var tabBarOffsets: IBSExtendedTabBarController.TabBarOffsets { get }

    ///
    ///
    ///
    var tabBarStyle: IBSExtendedTabBarController.TabBarStyle { get }
}
