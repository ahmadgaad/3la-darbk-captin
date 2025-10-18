#!/bin/bash

# iOS App Signing Setup Script
# This script helps configure iOS app signing for the Ala Darbak Captain app

echo "iOS App Signing Setup for Ala Darbak Captain"
echo "============================================="

# Check if Xcode is installed
if ! command -v xcodebuild &> /dev/null; then
    echo "Error: Xcode is not installed or not in PATH"
    echo "Please install Xcode from the App Store"
    exit 1
fi

echo "✓ Xcode is installed"

# Check if we're in the iOS directory
if [ ! -f "Runner.xcodeproj/project.pbxproj" ]; then
    echo "Error: Please run this script from the ios directory"
    exit 1
fi

echo "✓ Found iOS project"

# Instructions for manual setup
echo ""
echo "To complete iOS signing setup, you need to:"
echo ""
echo "1. Open Runner.xcodeproj in Xcode"
echo "2. Select the Runner target"
echo "3. Go to 'Signing & Capabilities' tab"
echo "4. Check 'Automatically manage signing'"
echo "5. Select your Development Team"
echo "6. Update the Bundle Identifier to something unique (e.g., com.yourcompany.alaDarbakCaptain)"
echo ""
echo "For App Store distribution:"
echo "1. Create an App Store provisioning profile"
echo "2. Set CODE_SIGN_STYLE = Manual"
echo "3. Select the appropriate provisioning profile"
echo "4. Use 'iPhone Distribution' as CODE_SIGN_IDENTITY"
echo ""

# Update bundle identifier to be more unique
echo "Current bundle identifier: com.example.alaDarbakCaptain"
echo "Consider changing this to something unique like: com.yourcompany.alaDarbakCaptain"
echo ""

echo "Setup instructions completed!"
echo "Run 'flutter build ios --release' to build a signed iOS app"
