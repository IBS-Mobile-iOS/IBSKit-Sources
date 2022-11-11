//
//  IBSVideoPlayerDelegate.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSVideoPlayerDelegate

///
///
///
@available(iOS 13.0, *)
public protocol IBSVideoPlayerDelegate: AnyObject {

    // MARK: - Public methods

    ///
    ///
    ///
    func downloadedProgress(with progress: Double)

    ///
    ///
    ///
    func readyToPlay()

    ///
    ///
    ///
    func didUpdateProgress(with progress: Double, and currentTime: Double?)

    ///
    ///
    ///
    func didFinishPlayItem()

    ///
    ///
    ///
    func didFailPlayToEnd()
}
