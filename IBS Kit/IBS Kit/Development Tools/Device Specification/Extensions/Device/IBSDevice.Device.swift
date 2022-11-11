//
//  IBSDevice.Device.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Device

extension IBSDevice {

    ///
    /// A structure describing the type, model, and name of the current device.
    ///
    public struct Device {

        ///
        /// A property that allows you to get the type of the current device.
        ///
        public var type: `Type`

        ///
        /// A property that allows you to get the model of the current device.
        ///
        public var model: Model

        ///
        /// A property that allows you to get the name of the current device.
        ///
        public var name: Name
    }
}
