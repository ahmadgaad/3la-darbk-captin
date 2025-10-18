# App Signing Configuration Guide

This document explains how the Ala Darbak Captain app is configured for signing on both Android and iOS platforms.

## Android Signing

### Files Created/Modified:
- `android/key.properties` - Contains keystore configuration
- `android/app/ala-darbak-captain-key.jks` - The keystore file
- `android/app/build.gradle.kts` - Updated with signing configuration
- `android/app/proguard-rules.pro` - ProGuard rules for release builds

### Configuration Details:
- **Keystore**: `ala-darbak-captain-key.jks`
- **Key Alias**: `ala-darbak-captain-key`
- **Key Algorithm**: RSA 2048-bit
- **Validity**: 10,000 days
- **Passwords**: Currently set to "android" (CHANGE THESE IN PRODUCTION!)

### Security Notes:
⚠️ **IMPORTANT**: The current keystore uses default passwords ("android"). 
For production releases, you MUST:
1. Generate a new keystore with strong, unique passwords
2. Store the passwords securely
3. Never commit the keystore or key.properties to version control

### Building Signed APK:
```bash
flutter build apk --release
```

## iOS Signing

### Current Configuration:
- **Bundle ID**: `com.example.alaDarbakCaptain`
- **Signing Style**: Automatic (requires Xcode setup)
- **Code Sign Identity**: iPhone Developer

### Setup Required:
1. Open `ios/Runner.xcodeproj` in Xcode
2. Select the Runner target
3. Go to "Signing & Capabilities" tab
4. Check "Automatically manage signing"
5. Select your Apple Developer Team
6. Update Bundle Identifier to be unique

### For App Store Distribution:
1. Create App Store provisioning profile
2. Set CODE_SIGN_STYLE = Manual
3. Select appropriate provisioning profile
4. Use "iPhone Distribution" as CODE_SIGN_IDENTITY

### Building Signed iOS App:
```bash
flutter build ios --release
```

## Security Best Practices

### Android:
1. **Never commit keystore files** to version control
2. **Use strong passwords** for production keystores
3. **Backup keystore securely** - losing it means you can't update your app
4. **Use different keystores** for debug and release builds
5. **Consider using Google Play App Signing** for additional security

### iOS:
1. **Use Apple Developer Program** for distribution
2. **Keep provisioning profiles updated**
3. **Use different certificates** for development and distribution
4. **Enable App Store Connect** for automatic signing when possible

## Environment Variables (Optional)

For enhanced security, you can use environment variables instead of storing passwords in key.properties:

```bash
# Add to your shell profile (.bashrc, .zshrc, etc.)
export KEYSTORE_PASSWORD="your_secure_password"
export KEY_PASSWORD="your_secure_password"
```

Then update `android/key.properties`:
```
storePassword=${KEYSTORE_PASSWORD}
keyPassword=${KEY_PASSWORD}
keyAlias=ala-darbak-captain-key
storeFile=app/ala-darbak-captain-key.jks
```

## Troubleshooting

### Android:
- **Build fails**: Check if keystore file exists and passwords are correct
- **APK not signed**: Verify signingConfig is set to "release" in build.gradle.kts
- **Permission denied**: Ensure keystore file has proper read permissions

### iOS:
- **Code signing error**: Check Apple Developer account and certificates
- **Provisioning profile issues**: Verify bundle ID matches profile
- **Team not selected**: Ensure development team is selected in Xcode

## Next Steps

1. **Test the signing configuration** by building release versions
2. **Update passwords** for production use
3. **Set up CI/CD** with proper secret management
4. **Configure app store deployment** when ready for distribution
