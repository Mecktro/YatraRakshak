# YatraRakshak Flutter App Integration Guide

## Overview
This Flutter app provides a unified interface for your existing YatraRakshak modules:
- Blockchain ID generation and verification
- Geo-fencing with high alert areas
- SOS emergency system
- AI/ML chatbot assistance
- Emergency contacts management

## Project Structure
```
lib/
├── main.dart                    # App entry point
├── providers/
│   └── app_state_provider.dart  # Global state management
├── screens/
│   ├── home_screen.dart         # Main navigation and home tab
│   ├── blockchain_screen.dart   # Blockchain ID display and management
│   ├── sos_screen.dart          # Emergency SOS functionality
│   ├── geofencing_screen.dart   # Geo-fencing alerts and risk areas
│   ├── ai_chat_screen.dart      # AI assistant chat interface
│   └── emergency_contacts_screen.dart # Emergency contacts management
├── widgets/
│   ├── sos_switch_widget.dart   # SOS toggle widget
│   ├── blockchain_id_widget.dart # Blockchain ID display widget
│   └── risk_level_indicator.dart # Risk level indicator widget
├── services/
│   └── yatrarakshak_integration.dart # Integration with existing modules
└── utils/
    └── theme.dart               # App theme and styling
```

## Integration with Existing Modules

### 1. Blockchain Module Integration
Your existing blockchain module can be integrated through the `YatraRakshakIntegration` service:

```dart
// Generate new blockchain ID
String? newId = await YatraRakshakIntegration.generateBlockchainId();

// Verify existing ID
bool isValid = await YatraRakshakIntegration.verifyBlockchainId(existingId);

// Get transaction history
Map<String, dynamic>? history = await YatraRakshakIntegration.getBlockchainTransactionHistory(id);
```

### 2. Geo-fencing Module Integration
Connect your geo-fencing system:

```dart
// Initialize geofencing
await YatraRakshakIntegration.initializeGeofencing();

// Add new geofence
await YatraRakshakIntegration.addGeofence(
  id: 'area_1',
  latitude: 19.0760,
  longitude: 72.8777,
  radius: 500.0,
  riskLevel: 3,
);

// Get nearby geofences
List<Map<String, dynamic>>? nearbyAreas = await YatraRakshakIntegration.getNearbyGeofences();
```

### 3. SOS Module Integration
Connect your emergency SOS system:

```dart
// Activate SOS
await YatraRakshakIntegration.activateSOS(
  latitude: currentLat,
  longitude: currentLng,
  message: 'Emergency assistance needed',
);

// Send emergency alert
await YatraRakshakIntegration.sendEmergencyAlert(
  contactNumber: '100',
  message: 'Emergency at current location',
  latitude: currentLat,
  longitude: currentLng,
);
```

### 4. AI/ML Module Integration
Connect your AI assistant:

```dart
// Process AI query
String? response = await YatraRakshakIntegration.processAIQuery(
  query: 'Is this area safe for tourists?',
  latitude: currentLat,
  longitude: currentLng,
  context: 'tourism_safety',
);
```

## Implementation Steps

### Step 1: Set up Flutter Environment
1. Install Flutter SDK from https://flutter.dev/docs/get-started/install
2. Add Flutter to your system PATH
3. Run `flutter doctor` to verify installation

### Step 2: Install Dependencies
```bash
cd app
flutter pub get
```

### Step 3: Configure Android
1. Update `android/app/src/main/AndroidManifest.xml` with necessary permissions
2. Add your Google Maps API key
3. Configure background services for location tracking

### Step 4: Create Platform Channels
Create native Android/iOS code to bridge your existing modules:

**Android (MainActivity.java):**
```java
public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "yatrarakshak_integration";
    
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                switch (call.method) {
                    case "generateBlockchainId":
                        // Call your blockchain module
                        String id = BlockchainModule.generateId();
                        result.success(id);
                        break;
                    case "activateSOS":
                        // Call your SOS module
                        SOSModule.activate(call.arguments);
                        result.success(null);
                        break;
                    // Add more method handlers...
                }
            });
    }
}
```

### Step 5: Add Your Existing Module JARs/AARs
1. Place your compiled modules in `android/app/libs/`
2. Update `android/app/build.gradle`:
```gradle
dependencies {
    implementation fileTree(dir: 'libs', include: ['*.jar', '*.aar'])
    // Your existing modules
    implementation files('libs/yatrarakshak-blockchain.jar')
    implementation files('libs/yatrarakshak-geofencing.jar')
    implementation files('libs/yatrarakshak-sos.jar')
    implementation files('libs/yatrarakshak-ai.jar')
}
```

### Step 6: Test Integration
```bash
# Run the app
flutter run

# Build for release
flutter build apk --release
```

## Features Overview

### Home Screen
- Quick access to all features
- Current risk level display
- Blockchain ID widget
- SOS status indicator

### Blockchain Screen
- Display current blockchain ID
- Copy/share functionality
- View transaction history
- Regenerate ID option

### SOS Screen
- Large emergency button
- Animated indicators when active
- Quick call buttons for emergency services
- Emergency instructions

### Geo-fencing Screen
- List of nearby risk areas with ratings
- Filter by risk level
- Map view integration ready
- Custom geofence creation

### AI Chat Screen
- ChatGPT-like interface
- Context-aware responses
- Quick question buttons
- Travel safety guidance

### Emergency Contacts Screen
- Quick dial emergency numbers
- Custom contact management
- Emergency tips and instructions

## Customization

### Theming
Modify `lib/utils/theme.dart` to match your brand colors:
```dart
static const Color primaryBlue = Color(0xFF1E88E5); // Your primary color
static const Color safetyGreen = Color(0xFF4CAF50); // Your secondary color
```

### Adding New Features
1. Create new screen in `lib/screens/`
2. Add to navigation in `home_screen.dart`
3. Update provider if needed for state management

### Connecting Real AI
Replace the simulated AI responses in `ai_chat_screen.dart` with calls to your actual AI service:
```dart
String response = await YatraRakshakIntegration.processAIQuery(
  query: userMessage,
  latitude: currentLat,
  longitude: currentLng,
);
```

## Security Considerations
1. All blockchain operations are handled through your existing secure modules
2. Location data is processed locally and only shared when explicitly needed
3. Emergency contacts are stored locally on device
4. AI queries can be processed locally or sent to your secure servers

## Testing
1. Test each module integration individually
2. Verify emergency features work without network
3. Test location permissions and background operation
4. Verify blockchain ID generation and verification

## Deployment
1. Configure signing certificates for release builds
2. Test on physical devices with real GPS
3. Submit to app stores with proper permissions explanations
4. Set up crash reporting and analytics

## Support
For integration issues, check:
1. Flutter logs: `flutter logs`
2. Android logs: `adb logcat`
3. Module status: Use `YatraRakshakIntegration.checkModuleStatus()`

This Flutter app provides a modern, user-friendly interface for your existing YatraRakshak safety modules while maintaining all the security and functionality you've already built.