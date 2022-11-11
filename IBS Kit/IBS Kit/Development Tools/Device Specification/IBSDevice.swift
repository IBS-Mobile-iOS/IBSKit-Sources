//
//  IBSDevice.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSDevice

///
/// A class that implements the iOS / iPadOS device specification.
///
@available(iOS 13.0, *)
public final class IBSDevice: IBSDeviceSpecificationable {

    // MARK: - Static properties

    ///
    /// A shared property that allows access to the properties of a class that implements the IBSDeviceSpecificationable protocol.
    ///
    public static let current: IBSDeviceSpecificationable = IBSDevice()



    // MARK: - Public properties

    ///
    /// A property that allows you to get information about the current device.
    ///
    public var device: Device {
        var device: Device = .init(
            type: .unknown,
            model: .unknown,
            name: .undefined
        )

        guard let propertyList else {
            return device
        }

        if deviceModelID.contains("iPod") {
            device.type = .iPod
        } else if deviceModelID.contains("iPhone") {
            device.type = .iPhone
        } else if deviceModelID.contains("iPad") {
            device.type = .iPad
        }

        switch device.type {
        case .iPod:
            device.model = .iPod_touch
        case .iPhone:
            device.model = .iPhone
        case .iPad:
            device.model = .iPad
        case .unknown:
            break
        }

        device.name = .init(rawValue: propertyList["Device Name"] as! String) ?? .undefined

        return device
    }

    ///
    /// A property that allows you to get information about the current version of the operating system.
    ///
    public var operatingSystem: OperatingSystem {
        var operatingSystem: OperatingSystem = .init(
            type: .unknown,
            name: .undefined,
            fullname: "",
            version: .init(
                major: 0,
                minor: 0,
                patch: 0
            )
        )

        guard let _ = propertyList else {
            return operatingSystem
        }

        operatingSystem.type = .mobile

        switch device.type {
        case .iPod:
            operatingSystem.name = .iOS
        case .iPhone:
            operatingSystem.name = .iOS
        case .iPad:
            operatingSystem.name = .iPadOS
        case .unknown:
            operatingSystem.type = .unknown
        }

        let process = ProcessInfo()

        let majorVersion = UInt16(process.operatingSystemVersion.majorVersion)
        let minorVersion = UInt16(process.operatingSystemVersion.minorVersion)
        let patchVersion = UInt16(process.operatingSystemVersion.patchVersion)

        switch device.type {
        case .iPod, .iPhone, .iPad:
            operatingSystem.fullname =
"""
\(operatingSystem.name.rawValue) \(majorVersion).\(minorVersion).\(patchVersion)
"""
        case .unknown:
            break
        }

        switch device.type {
        case .iPod, .iPhone, .iPad:
            operatingSystem.version = .init(
                major: majorVersion,
                minor: minorVersion,
                patch: patchVersion
            )
        case .unknown:
            break
        }

        return operatingSystem
    }

    ///
    /// A property that allows you to get information about the current device software.
    ///
    public var software: Software {
        var software: Software = .init(
            type: .iOS,
            isSimulatorEnvironment: false,
            isLowPowerModeEnabled: false
        )

        guard let _ = propertyList else {
            return software
        }

#if targetEnvironment(simulator)
        software.isSimulatorEnvironment = true
#endif

        let process = ProcessInfo()

        software.isLowPowerModeEnabled = process.isLowPowerModeEnabled

        return software
    }

    ///
    /// A property that allows you to get information about the current hardware of the device.
    ///
    public var hardware: Hardware {
        var hardware: Hardware = .init(
            connectivity: .init(
                gps: .unavailable,
                iBeacon: .unavailable,
                bluetooth: .unavailable
            ),
            imu: .init(
                accelerometer: .unavailable,
                barometer: .unavailable,
                gyroscope: .unavailable,
                magnetometer: .unavailable
            ),
            network: .init(
                cellular: .unavailable,
                wifi: .unavailable
            )
        )

        guard let propertyList else {
            return hardware
        }

        hardware.connectivity.bluetooth = (propertyList["Bluetooth Supported"] as! Bool) ? .available : .unavailable
        hardware.connectivity.gps = (propertyList["GPS Supported"] as! Bool) ? .available : .unavailable
        hardware.connectivity.iBeacon = (propertyList["iBeacon Supported"] as! Bool) ? .available : .unavailable

        hardware.imu.accelerometer = (propertyList["Accelerometer Supported"] as! Bool) ? .available : .unavailable
        hardware.imu.barometer = (propertyList["Barometer Supported"] as! Bool) ? .available : .unavailable
        hardware.imu.gyroscope = (propertyList["Gyroscope Supported"] as! Bool) ? .available : .unavailable
        hardware.imu.magnetometer = (propertyList["Magnetometer Supported"] as! Bool) ? .available : .unavailable

        hardware.network.cellular = (propertyList["Cellular Supported"] as! Bool) ? .available : .unavailable
        hardware.network.wifi = (propertyList["Wi-Fi Supported"] as! Bool) ? .available : .unavailable

        return hardware
    }

    ///
    /// A property that allows you to get the full specification of the current device.
    ///
    public var specification: Specification {
        .init(
            device: device,
            operatingSystem: operatingSystem,
            software: software,
            hardware: hardware
        )
    }



    // MARK: - Private properties

    private let deviceModelID: String = {
        let process = ProcessInfo()

#if targetEnvironment(simulator)
        guard let simulatorModelID = process.environment["SIMULATOR_MODEL_IDENTIFIER"] else {
            return ""
        }

        return simulatorModelID
#elseif os(iOS)
        var systemInfo = utsname()
        uname(&systemInfo)

        return String(bytes: Data(bytes: &systemInfo.machine,
                                  count: Int(_SYS_NAMELEN)),
                      encoding: .ascii)!
            .trimmingCharacters(in: .controlCharacters)
#endif
    }()

    private lazy var propertyList: [String: Any]? = {
        var plist: [String: Any]?

        guard let url = Bundle(identifier: "ru.ibs.ibskit")?.url(
            forResource: deviceModelID,
            withExtension: "plist"
        ) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: url)

            if let dictionary = try PropertyListSerialization
                .propertyList(
                    from: data,
                    options: [],
                    format: nil
                ) as? [String: Any] {
                plist = dictionary
            }
        } catch {
            return nil
        }

        return plist
    }()



    // MARK: - Init

    private init() { }
}

