//
//  IBSAppSpecificationable.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSAppSpecificationable

///
/// A protocol that describes the application specification.
///
@available(iOS 13.0, *)
public protocol IBSAppSpecificationable: AnyObject {

    // MARK: - Public properties

    ///
    /// A property that allows you to get the version of the running application.
    ///
    var version: IBSApp.Version { get }

    ///
    /// A property that allows you to get the build version of the running application.
    ///
    var build: IBSApp.Build { get }
}
