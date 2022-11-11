//
//  IBSDevice.Hardware.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Hardware

extension IBSDevice {

    ///
    /// A structure that describes the availability of sensors on the hardware component of the current device.
    ///
    public struct Hardware {

        ///
        /// A property that allows you to get information about the sensors of the Connectivity section.
        ///
        public var connectivity: Connectivity

        ///
        /// A property that allows you to get information about the sensors of the IMU section.
        ///
        public var imu: IMU

        ///
        /// A property that allows you to get information about the sensors of the Network section.
        ///
        public var network: Network
    }
}
