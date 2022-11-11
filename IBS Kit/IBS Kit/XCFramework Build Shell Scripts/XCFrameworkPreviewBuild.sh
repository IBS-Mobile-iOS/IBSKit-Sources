#!/bin/sh

#  XCFrameworkPreviewBuild.sh
#  IBS Kit
#
#  Created by Dimka Novikov on 11.11.2022.
#  Copyright © 2022 IBS. All rights reserved.


# Clean folder from previous files
rm -rd "../XCFramework/"

# Archive framework for iOS
xcodebuild archive \
    -scheme IBSKit \
    -archivePath "../XCFramework/IBSKit-iOS.xcarchive" \
    -sdk iphoneos \
    SKIP_INSTALL=NO

# Archive framework for iOS Simulator
xcodebuild archive \
    -scheme IBSKit \
    -archivePath "../XCFramework/IBSKit-iOSSimulator.xcarchive" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO

# Create universal framework bundle
xcodebuild -create-xcframework \
    -framework "../XCFramework/IBSKit-iOS.xcarchive/Products/Library/Frameworks/IBSKit.framework" \
    -framework "../XCFramework/IBSKit-iOSSimulator.xcarchive/Products/Library/Frameworks/IBSKit.framework" \
    -output "../XCFramework/IBSKit.xcframework"

# Delete archived framework created for iOS
rm -rd "../XCFramework/IBSKit-iOS.xcarchive"

# Delete archived framework created for iOS Simulator
rm -rd "../XCFramework/IBSKit-iOSSimulator.xcarchive"
