//
//  IBSDevice.Software.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Software

extension IBSDevice {

    ///
    /// A structure describing the application type, simulator environment, and Low Power Mode activity.
    ///
    public struct Software {

        ///
        /// A property that allows you to get the type of application running on the current device.
        ///
        public var type: `Type`

        ///
        /// A property that allows you to get information about whether the simulator environment is used or the application is running on a real device.
        ///
        public var isSimulatorEnvironment: Bool

        ///
        /// A property that allows you to get information about whether the power saving mode is enabled.
        ///
        public var isLowPowerModeEnabled: Bool
    }
}
