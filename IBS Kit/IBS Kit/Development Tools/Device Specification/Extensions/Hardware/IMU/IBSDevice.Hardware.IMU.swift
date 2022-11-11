//
//  IBSDevice.Hardware.IMU.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice.Hardware.IMU

extension IBSDevice.Hardware {

    ///
    /// A structure describing the availability of IMU section sensors.
    ///
    public struct IMU {
        public var accelerometer: SensorAvailability
        public var barometer: SensorAvailability
        public var gyroscope: SensorAvailability
        public var magnetometer: SensorAvailability
    }
}
