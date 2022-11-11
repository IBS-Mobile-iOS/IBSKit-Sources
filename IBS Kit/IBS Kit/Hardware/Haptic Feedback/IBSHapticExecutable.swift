//
//  IBSHapticExecutable.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSHapticExecutable

///
/// A protocol that describes the operation of  Haptic Feedback.
///
@available(iOS 13.0, *)
public protocol IBSHapticExecutable: AnyObject {

    // MARK: - Public methods

    ///
    /// A method that implements haptic feedback with a given feedback type.
    ///
    /// Allows you to use the  Taptic Engine without using wrappers to reconciliate the device type, and also supports multithreading by default.
    ///
    /// To implement taptic feedback, it is enough to refer to the `execute(with: IBSHaptic.FeedbackType)` method.
    ///
    /// Example:
    ///
    ///     IBSHaptic.feedback.execute(with: .success)
    ///
    /// - Parameters:
    ///    - feedbackType: Enumeration of the types of possible haptic feedback.
    ///
    /// - Authors: Dmitry Novikov
    ///
    /// - Bug: None
    ///
    func execute(with feedbackType: IBSHaptic.FeedbackType)
}
