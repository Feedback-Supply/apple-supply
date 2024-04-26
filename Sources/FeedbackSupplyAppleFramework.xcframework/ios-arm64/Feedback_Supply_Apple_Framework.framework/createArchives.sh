#!/bin/sh

FRAMEWORK="Feedback Supply Apple Framework"
FRAMEWORK_CONDENSED="FeedbackSupplyAppleFramework"

rm -r ./build
rm -r ./frameworks
rm -r ./xcframeworks

# iOS devices
TARGET=iOS
xcodebuild archive \
  -quiet \
  -project "Feedback Supply Apple Framework.xcodeproj" \
  -scheme "Feedback Supply Apple Framework" \
  -destination "generic/platform=iOS" \
  -archivePath "archives/FeedbackSupplyAppleFramework-iOS" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO \
  OTHER_SWIFT_FLAGS=-no-verify-emitted-module-interface

#-configuration Release \
# iOS simulator
TARGET=iOS_Simulator
xcodebuild archive \
  -quiet \
  -project "Feedback Supply Apple Framework.xcodeproj" \
  -scheme "Feedback Supply Apple Framework" \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "archives/FeedbackSupplyAppleFramework-iOS_Simulator" \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
  SKIP_INSTALL=NO \
  OTHER_SWIFT_FLAGS=-no-verify-emitted-module-interface

# macOS devices
# TARGET=macOS
# xcodebuild archive \
#   -project "Feedback Supply Apple Framework.xcodeproj" \
#   -scheme "Feedback Supply Apple Framework" \
#   -destination "generic/platform=macOS" \
#   -archivePath "archives/FeedbackSupplyAppleFramework-macOS" \
#   BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
#   SKIP_INSTALL=NO \
#   OTHER_SWIFT_FLAGS=-no-verify-emitted-module-interface

xcodebuild -create-xcframework \
    -archive archives/FeedbackSupplyAppleFramework-iOS.xcarchive -framework Feedback_Supply_Apple_Framework.framework \
    -archive archives/FeedbackSupplyAppleFramework-iOS_Simulator.xcarchive -framework Feedback_Supply_Apple_Framework.framework \
    -output xcframeworks/FeedbackSupplyAppleFramework.xcframework
    
    # -archive archives/FeedbackSupplyAppleFramework-macOS.xcarchive -framework Feedback_Supply_Apple_Framework.framework \

codesign --timestamp -s <identity> xcframeworks/FeedbackSupplyAppleFramework.xcframework

