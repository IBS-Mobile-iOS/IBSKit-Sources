//
//  IBSSplitSpaceControllerPresentable.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import UIKit



// MARK: - IBSSplitSpaceControllerPresentable

///
/// A protocol that describes properties for rendering an IBSSplitSpaceController.
///
@available(iOS 13.0, *)
public protocol IBSSplitSpaceControllerPresentable: AnyObject {

    // MARK: - Public properties

    ///
    /// A property that allows you to set the minimum size of the left side.
    ///
    var minimumLeftSideSize: CGFloat { get }

    ///
    /// A property that allows you to set the maximum size of the left side.
    ///
    var maximumLeftSideSize: CGFloat { get }

    ///
    /// A property that allows you to set the initial state of the left side.
    ///
    var leftSideInitialState: IBSSplitSpaceController.LeftSideInitialState { get }

    ///
    /// A property that allows you to set the supported states by the left side.
    ///
    var leftSideSupportedState: IBSSplitSpaceController.LeftSideSupportedState { get }

    ///
    /// A property that allows you to specify a custom ViewController as the left side.
    ///
    var leftSideViewController: UIViewController { get set }

    ///
    /// A property that allows you to specify a custom ViewController as the right side.
    ///
    var rightSideViewController: UIViewController { get set }

    ///
    /// A property that allows you to get information about whether the left side is currently collapsed or expanded.
    ///
    var isLeftSideCollapsed: Bool { get set }
}
