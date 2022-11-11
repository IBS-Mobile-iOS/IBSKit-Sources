#!/bin/sh

#  XCFrameworkReleaseBuild.sh
#  IBS Kit
#
#  Created by Dimka Novikov on 11.11.2022.
#  Copyright © 2022 IBS. All rights reserved.


# Clean folder from previous files
rm -rd "../../IBS SDK/XCFramework/"

# Archive framework for iOS
xcodebuild archive \
    -scheme IBSKit \
    -archivePath "../../IBS SDK/XCFramework/IBSKit-iOS.xcarchive" \
    -sdk iphoneos \
    SKIP_INSTALL=NO

# Archive framework for iOS Simulator
xcodebuild archive \
    -scheme IBSKit \
    -archivePath "../../IBS SDK/XCFramework/IBSKit-iOSSimulator.xcarchive" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO

# Create universal framework bundle
xcodebuild -create-xcframework \
    -framework "../../IBS SDK/XCFramework/IBSKit-iOS.xcarchive/Products/Library/Frameworks/IBSKit.framework" \
    -framework "../../IBS SDK/XCFramework/IBSKit-iOSSimulator.xcarchive/Products/Library/Frameworks/IBSKit.framework" \
    -output "../../IBS SDK/XCFramework/IBSKit.xcframework"

# Delete archived framework created for iOS
rm -rd "../../IBS SDK/XCFramework/IBSKit-iOS.xcarchive"

# Delete archived framework created for iOS Simulator
rm -rd "../../IBS SDK/XCFramework/IBSKit-iOSSimulator.xcarchive"

# Create XCFramework.zip
# zip -r "../../IBSKit/XCFramework/IBSKit.xcframework.zip" "../../IBSKit/XCFramework/IBSKit.xcframework"

# Calculate Hash-sum of .zip folder
# swift package compute-checksum "../../IBSKit/XCFramework/IBSKit.xcframework.zip"

# Remove XCFramework.zip
# rm -rd "../../IBSKit/XCFramework/IBSKit.xcframework.zip"
