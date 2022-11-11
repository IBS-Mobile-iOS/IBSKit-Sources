//
//  IBSApp.Version.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSApp.Version

extension IBSApp {

    ///
    /// A structure describing the version of the application as a major.minor.patch.
    ///
    public struct Version {

        ///
        /// A property that allows you to get the major version of the application.
        ///
        public var major: UInt16

        ///
        /// A property that allows you to get the minor version of the application.
        ///
        public var minor: UInt16

        ///
        /// A property that allows you to get a patch version of the application.
        ///
        public var patch: UInt16
    }
}
