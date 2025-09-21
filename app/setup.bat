@echo off
echo ===================================
echo YatraRakshak Flutter App Setup
echo ===================================
echo.

echo Checking Flutter installation...
flutter --version
if %errorlevel% neq 0 (
    echo ERROR: Flutter is not installed or not in PATH
    echo Please install Flutter from https://flutter.dev/docs/get-started/install
    echo And add it to your system PATH
    pause
    exit /b 1
)

echo.
echo Setting up Flutter project...
echo.

echo Running flutter pub get...
flutter pub get
if %errorlevel% neq 0 (
    echo ERROR: Failed to get dependencies
    echo Please check your internet connection and try again
    pause
    exit /b 1
)

echo.
echo Running flutter doctor...
flutter doctor
if %errorlevel% neq 0 (
    echo WARNING: Some issues found with Flutter setup
    echo Please resolve the issues shown above
)

echo.
echo Project setup complete!
echo.
echo To run the app:
echo   1. Connect an Android device or start an Android emulator
echo   2. Run: flutter run
echo.
echo To build the app:
echo   - Debug: flutter build apk --debug
echo   - Release: flutter build apk --release
echo.
pause