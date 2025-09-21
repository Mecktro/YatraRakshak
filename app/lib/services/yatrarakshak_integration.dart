// Integration service for existing YatraRakshak modules
// This file provides interfaces to integrate your existing blockchain, 
// geofencing, and SOS modules with the Flutter app

import 'dart:async';
import 'package:flutter/services.dart';

class YatraRakshakIntegration {
  static const MethodChannel _channel = MethodChannel('yatrarakshak_integration');

  // Blockchain Integration
  static Future<String?> generateBlockchainId() async {
    try {
      final String? result = await _channel.invokeMethod('generateBlockchainId');
      return result;
    } catch (e) {
      print('Error generating blockchain ID: $e');
      return null;
    }
  }

  static Future<bool> verifyBlockchainId(String id) async {
    try {
      final bool result = await _channel.invokeMethod('verifyBlockchainId', {'id': id});
      return result;
    } catch (e) {
      print('Error verifying blockchain ID: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>?> getBlockchainTransactionHistory(String id) async {
    try {
      final Map<String, dynamic>? result = await _channel.invokeMethod(
        'getTransactionHistory', 
        {'id': id}
      );
      return result;
    } catch (e) {
      print('Error getting transaction history: $e');
      return null;
    }
  }

  // Geofencing Integration
  static Future<void> initializeGeofencing() async {
    try {
      await _channel.invokeMethod('initializeGeofencing');
    } catch (e) {
      print('Error initializing geofencing: $e');
    }
  }

  static Future<void> addGeofence({
    required String id,
    required double latitude,
    required double longitude,
    required double radius,
    required int riskLevel,
  }) async {
    try {
      await _channel.invokeMethod('addGeofence', {
        'id': id,
        'latitude': latitude,
        'longitude': longitude,
        'radius': radius,
        'riskLevel': riskLevel,
      });
    } catch (e) {
      print('Error adding geofence: $e');
    }
  }

  static Future<void> removeGeofence(String id) async {
    try {
      await _channel.invokeMethod('removeGeofence', {'id': id});
    } catch (e) {
      print('Error removing geofence: $e');
    }
  }

  static Future<List<Map<String, dynamic>>?> getNearbyGeofences() async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod('getNearbyGeofences');
      return result?.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error getting nearby geofences: $e');
      return null;
    }
  }

  // SOS Integration
  static Future<void> activateSOS({
    required double latitude,
    required double longitude,
    String? message,
  }) async {
    try {
      await _channel.invokeMethod('activateSOS', {
        'latitude': latitude,
        'longitude': longitude,
        'message': message ?? 'Emergency SOS activated',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      print('Error activating SOS: $e');
    }
  }

  static Future<void> deactivateSOS() async {
    try {
      await _channel.invokeMethod('deactivateSOS');
    } catch (e) {
      print('Error deactivating SOS: $e');
    }
  }

  static Future<bool> getSOSStatus() async {
    try {
      final bool result = await _channel.invokeMethod('getSOSStatus');
      return result;
    } catch (e) {
      print('Error getting SOS status: $e');
      return false;
    }
  }

  static Future<void> sendEmergencyAlert({
    required String contactNumber,
    required String message,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await _channel.invokeMethod('sendEmergencyAlert', {
        'contactNumber': contactNumber,
        'message': message,
        'latitude': latitude,
        'longitude': longitude,
      });
    } catch (e) {
      print('Error sending emergency alert: $e');
    }
  }

  // Location Services Integration
  static Future<Map<String, double>?> getCurrentLocation() async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod('getCurrentLocation');
      if (result != null) {
        return {
          'latitude': result['latitude']?.toDouble() ?? 0.0,
          'longitude': result['longitude']?.toDouble() ?? 0.0,
        };
      }
      return null;
    } catch (e) {
      print('Error getting current location: $e');
      return null;
    }
  }

  static Future<int> calculateRiskLevel(double latitude, double longitude) async {
    try {
      final int result = await _channel.invokeMethod('calculateRiskLevel', {
        'latitude': latitude,
        'longitude': longitude,
      });
      return result;
    } catch (e) {
      print('Error calculating risk level: $e');
      return 1; // Default to safe
    }
  }

  // AI/ML Integration
  static Future<String?> processAIQuery({
    required String query,
    double? latitude,
    double? longitude,
    String? context,
  }) async {
    try {
      final String? result = await _channel.invokeMethod('processAIQuery', {
        'query': query,
        'latitude': latitude,
        'longitude': longitude,
        'context': context,
      });
      return result;
    } catch (e) {
      print('Error processing AI query: $e');
      return null;
    }
  }

  static Future<List<String>?> getLocationSafetySuggestions(
    double latitude, 
    double longitude
  ) async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod(
        'getLocationSafetySuggestions',
        {
          'latitude': latitude,
          'longitude': longitude,
        }
      );
      return result?.cast<String>();
    } catch (e) {
      print('Error getting safety suggestions: $e');
      return null;
    }
  }

  // Emergency Contacts Integration
  static Future<void> syncEmergencyContacts(List<Map<String, String>> contacts) async {
    try {
      await _channel.invokeMethod('syncEmergencyContacts', {'contacts': contacts});
    } catch (e) {
      print('Error syncing emergency contacts: $e');
    }
  }

  static Future<List<Map<String, String>>?> getLocalEmergencyNumbers() async {
    try {
      final List<dynamic>? result = await _channel.invokeMethod('getLocalEmergencyNumbers');
      return result?.cast<Map<String, String>>();
    } catch (e) {
      print('Error getting local emergency numbers: $e');
      return null;
    }
  }

  // Notification Integration
  static Future<void> scheduleLocationReminder() async {
    try {
      await _channel.invokeMethod('scheduleLocationReminder');
    } catch (e) {
      print('Error scheduling location reminder: $e');
    }
  }

  static Future<void> sendRiskLevelNotification(int riskLevel, String location) async {
    try {
      await _channel.invokeMethod('sendRiskLevelNotification', {
        'riskLevel': riskLevel,
        'location': location,
      });
    } catch (e) {
      print('Error sending risk level notification: $e');
    }
  }

  // Data Synchronization
  static Future<void> syncTravelData({
    required String blockchainId,
    required Map<String, dynamic> travelData,
  }) async {
    try {
      await _channel.invokeMethod('syncTravelData', {
        'blockchainId': blockchainId,
        'travelData': travelData,
      });
    } catch (e) {
      print('Error syncing travel data: $e');
    }
  }

  static Future<Map<String, dynamic>?> getTravelAnalytics(String blockchainId) async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod(
        'getTravelAnalytics',
        {'blockchainId': blockchainId}
      );
      return result?.cast<String, dynamic>();
    } catch (e) {
      print('Error getting travel analytics: $e');
      return null;
    }
  }

  // Module Status Check
  static Future<Map<String, bool>> checkModuleStatus() async {
    try {
      final Map<dynamic, dynamic>? result = await _channel.invokeMethod('checkModuleStatus');
      return result?.cast<String, bool>() ?? {
        'blockchain': false,
        'geofencing': false,
        'sos': false,
        'ai': false,
      };
    } catch (e) {
      print('Error checking module status: $e');
      return {
        'blockchain': false,
        'geofencing': false,
        'sos': false,
        'ai': false,
      };
    }
  }
}