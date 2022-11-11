//
//  IBSSDKSpecificationable.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSSDKSpecificationable

///
/// A protocol that describes the framework specification.
///
@available(iOS 13.0, *)
public protocol IBSSDKSpecificationable: AnyObject {

    // MARK: - Public properties

    ///
    /// A property that allows you to get the version of the framework being used.
    ///
    var version: IBSSDK.Version { get }

    ///
    /// A property that allows you to get the build version of the framework being used.
    ///
    var build: IBSSDK.Build { get }
}
