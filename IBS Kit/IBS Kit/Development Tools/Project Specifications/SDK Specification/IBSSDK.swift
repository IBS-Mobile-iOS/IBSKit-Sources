//
//  IBSSDK.swift
//  IBS Kit
//
//  Created by Dimka Novikov on 11.11.2022.
//  Copyright © 2022 IBS. All rights reserved.
//


// MARK: Import section

import Foundation



// MARK: - IBSSDK

///
/// A class that implements the framework specification.
///
@available(iOS 13.0, *)
public final class IBSSDK: IBSSDKSpecificationable {

    // MARK: - Static properties

    ///
    /// A shared property that allows access to the properties of a class that implements the IBSSDKSpecificationable protocol.
    ///
    public static let info: IBSSDKSpecificationable = IBSSDK()



    // MARK: - Public properties

    ///
    /// A property that allows you to get the version of the framework being used.
    ///
    public let version: Version = {
        var version: Version = .init(
            major: 0,
            minor: 0,
            patch: 0
        )

        guard
            let string = Bundle(identifier: "ru.ibs.ibskit")?
                .infoDictionary?["CFBundleShortVersionString"] as? String
        else {
            return version
        }

        let components = string.components(separatedBy: ["."])

        switch components.count {
        case 3:
            guard let patch = UInt16(components[2]) else { fallthrough }
            version.patch = patch
            fallthrough
        case 2:
            guard let minor = UInt16(components[1]) else { fallthrough }
            version.minor = minor
            fallthrough
        case 1:
            guard let major = UInt16(components[0]) else { fallthrough }
            version.major = major
        default:
            return version
        }

        return version
    }()

    ///
    /// A property that allows you to get the build version of the framework being used.
    ///
    public let build: Build = {
        guard
            let string = Bundle(identifier: "ru.ibs.ibskit")?
                .infoDictionary?["CFBundleVersion"] as? String
        else {
            return 0
        }

        guard
            let build = UInt16(string)
        else {
            return 0
        }

        return build
    }()



    // MARK: - Init

    private init() { }
}
