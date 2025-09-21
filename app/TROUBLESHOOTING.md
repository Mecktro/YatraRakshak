# YatraRakshak Flutter App - Troubleshooting Guide

## Common Issues and Solutions

### 1. Flutter Command Not Found
**Error**: `flutter: The term 'flutter' is not recognized`

**Solution**:
1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract to a location like `C:\flutter`
3. Add `C:\flutter\bin` to your system PATH
4. Restart your terminal/command prompt
5. Run `flutter doctor` to verify installation

### 2. Android License Issues
**Error**: `Android sdkmanager not found` or license acceptance issues

**Solution**:
1. Install Android Studio from https://developer.android.com/studio
2. Open Android Studio and install Android SDK
3. Run `flutter doctor --android-licenses` and accept all licenses
4. Run `flutter doctor` to verify Android setup

### 3. Gradle Build Failed
**Error**: `Gradle build failed` or `Could not resolve dependencies`

**Solution**:
1. Delete `android/.gradle` and `android/app/build` folders
2. Run `flutter clean`
3. Run `flutter pub get`
4. Try building again with `flutter build apk`

### 4. Permission Issues on Android
**Error**: App crashes when requesting location or phone permissions

**Solution**:
1. Make sure all permissions are declared in `android/app/src/main/AndroidManifest.xml`
2. For Android 6+ devices, implement runtime permission requests
3. Test on physical device rather than emulator for location features

### 5. Module Integration Issues
**Error**: Your existing modules don't work with the Flutter app

**Solution**:
1. Check `android/app/src/main/kotlin/com/example/yatrarakshak/MainActivity.kt`
2. Replace placeholder methods with actual calls to your modules
3. Add your module JAR/AAR files to `android/app/libs/`
4. Update `android/app/build.gradle` dependencies section

### 6. Hot Reload Not Working
**Error**: Changes not appearing in app during development

**Solution**:
1. Make sure you're running in debug mode: `flutter run`
2. Press `r` in terminal to hot reload, or `R` for hot restart
3. If still not working, stop and restart: `flutter run`

### 7. Build Size Too Large
**Error**: APK size is too large for distribution

**Solution**:
1. Build release version: `flutter build apk --release`
2. Enable code shrinking in `android/app/build.gradle`:
   ```gradle
   buildTypes {
       release {
           shrinkResources true
           minifyEnabled true
           proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
       }
   }
   ```

### 8. Network Issues with Dependencies
**Error**: `pub get failed` or dependency resolution errors

**Solution**:
1. Check internet connection
2. Try `flutter pub cache repair`
3. Delete `pubspec.lock` and run `flutter pub get`
4. If behind corporate firewall, configure proxy settings

### 9. Android Emulator Issues
**Error**: App doesn't run on Android emulator

**Solution**:
1. Make sure emulator has Google Play Services
2. Use API level 21 or higher (Android 5.0+)
3. Enable hardware acceleration in BIOS
4. Try running on physical device instead

### 10. Integration with Existing Modules
**Error**: Your blockchain/SOS/geofencing modules don't connect

**Solution**:
1. Study the integration service: `lib/services/yatrarakshak_integration.dart`
2. Implement platform channels in `MainActivity.kt`
3. Add your module dependencies to `android/app/build.gradle`
4. Test each module integration individually

## Quick Commands for Debugging

```bash
# Check Flutter installation
flutter doctor -v

# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check connected devices
flutter devices

# Build release APK
flutter build apk --release

# Run tests
flutter test

# Analyze code for issues
flutter analyze
```

## Getting Help

1. **Flutter Documentation**: https://flutter.dev/docs
2. **Flutter Community**: https://flutter.dev/community
3. **Stack Overflow**: Tag your questions with `flutter` and `android`
4. **GitHub Issues**: Check the Flutter GitHub repository for known issues

## Development Tips

1. **Use Android Studio** for better debugging and code completion
2. **Enable Developer Options** on your Android device
3. **Use Git** to track your changes and integration with existing modules
4. **Test on Real Devices** especially for location and calling features
5. **Monitor Performance** using Flutter DevTools

## Project Structure Reminder

```
YatraRakshak/app/
├── lib/                     # Flutter Dart code
│   ├── main.dart           # App entry point
│   ├── screens/            # All app screens
│   ├── widgets/            # Reusable UI components
│   ├── providers/          # State management
│   └── services/           # Integration services
├── android/                # Android-specific code
│   ├── app/build.gradle    # App build configuration
│   └── app/src/main/       # Android source code
├── assets/                 # Images, icons, etc.
└── pubspec.yaml           # Flutter dependencies
```

Remember: This app is designed to integrate with your existing YatraRakshak modules. The main integration points are in the `services/` directory and `MainActivity.kt`.