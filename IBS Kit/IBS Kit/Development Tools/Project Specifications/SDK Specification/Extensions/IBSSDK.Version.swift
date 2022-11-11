//
//  IBSSDK.Version.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSSDK.Version

extension IBSSDK {

    ///
    /// A structure describing the version of the framework as a major.minor.patch.
    ///
    public struct Version {

        ///
        /// A property that allows you to get the major version of the framework.
        ///
        public var major: UInt16

        ///
        /// A property that allows you to get the minor version of the framework.
        ///
        public var minor: UInt16

        ///
        /// A property that allows you to get the patch version of the framework.
        ///
        public var patch: UInt16
    }
}
