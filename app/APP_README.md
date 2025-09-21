# YatraRakshak Flutter App

A comprehensive Flutter application for tourism safety featuring blockchain identity, SOS emergency system, geo-fencing alerts, AI assistance, and emergency contacts management.

## Features

### 🛡️ Blockchain Identity
- Secure blockchain-based ID generation
- Identity verification system
- Transaction history tracking
- Copy and share functionality

### 🚨 Emergency SOS
- One-tap emergency activation
- Animated emergency indicators
- Quick dial emergency services
- Location sharing with emergency contacts

### 📍 Geo-fencing Alerts
- Real-time location risk assessment
- High alert area warnings with ratings (1-5 scale)
- Nearby risk area monitoring
- Custom geofence creation

### 🤖 AI Safety Assistant
- ChatGPT-like conversational interface
- Context-aware safety guidance
- Local area safety information
- Emergency assistance guidance
- Quick question templates

### 📞 Emergency Contacts
- Quick access to police (100), ambulance (108), fire (101)
- Tourist helpline integration
- Custom emergency contact management
- One-tap calling functionality

## Quick Start

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Android Studio / VS Code
- Android SDK / iOS SDK

### Installation
1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Architecture

```
lib/
├── main.dart                           # App entry point
├── providers/
│   └── app_state_provider.dart         # Global state management
├── screens/                            # All app screens
│   ├── home_screen.dart               # Main navigation hub
│   ├── blockchain_screen.dart         # Blockchain ID management
│   ├── sos_screen.dart               # Emergency SOS interface
│   ├── geofencing_screen.dart        # Geo-fencing alerts
│   ├── ai_chat_screen.dart           # AI assistant chat
│   └── emergency_contacts_screen.dart # Emergency contacts
├── widgets/                           # Reusable UI components
│   ├── sos_switch_widget.dart
│   ├── blockchain_id_widget.dart
│   └── risk_level_indicator.dart
├── services/
│   └── yatrarakshak_integration.dart  # Integration with existing modules
└── utils/
    └── theme.dart                     # App styling and themes
```

## Key Technologies

- **State Management**: Provider pattern
- **UI Framework**: Material Design 3
- **Location Services**: Geolocator
- **HTTP Requests**: Dio
- **Blockchain Integration**: Web3Dart
- **Local Storage**: SharedPreferences
- **Notifications**: Flutter Local Notifications

## Integration with Existing Modules

This app is designed to integrate with your existing YatraRakshak modules:

### Blockchain Module
```dart
// Generate new blockchain ID
String? newId = await YatraRakshakIntegration.generateBlockchainId();

// Verify existing ID
bool isValid = await YatraRakshakIntegration.verifyBlockchainId(existingId);
```

### Geo-fencing Module
```dart
// Add geofence area
await YatraRakshakIntegration.addGeofence(
  id: 'area_1',
  latitude: 19.0760,
  longitude: 72.8777,
  radius: 500.0,
  riskLevel: 3,
);
```

### SOS Module
```dart
// Activate emergency SOS
await YatraRakshakIntegration.activateSOS(
  latitude: currentLat,
  longitude: currentLng,
  message: 'Emergency assistance needed',
);
```

## Building for Release

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## Configuration

### Android Permissions
The app requires these permissions (already configured):
- Location access (fine and coarse)
- Phone call access
- SMS sending
- Internet access
- Background location

### API Keys
1. Add your Google Maps API key in `android/app/src/main/AndroidManifest.xml`
2. Configure your AI service endpoints in the integration service

## Security Features

- **Local Data Storage**: All sensitive data stored locally
- **Encrypted Communication**: All API calls use HTTPS
- **Permission Management**: Runtime permission requests
- **Background Services**: Secure location tracking when needed

## Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/new-feature`)
3. Commit changes (`git commit -am 'Add new feature'`)
4. Push to branch (`git push origin feature/new-feature`)
5. Create Pull Request

## Support

For technical support or integration assistance:
- Check the integration guide in README.md
- Review Flutter logs: `flutter logs`
- Check module status: `YatraRakshakIntegration.checkModuleStatus()`

## License

This project is part of the YatraRakshak tourism safety initiative.

---

**Built with ❤️ for safer tourism experiences**