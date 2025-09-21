import 'package:flutter/material.dart';

class AppStateProvider extends ChangeNotifier {
  // SOS Switch State
  bool _sosEnabled = false;
  bool get sosEnabled => _sosEnabled;
  
  void toggleSOS() {
    _sosEnabled = !_sosEnabled;
    notifyListeners();
  }

  // Blockchain ID
  String _blockchainId = 'YR-BC-${DateTime.now().millisecondsSinceEpoch}';
  String get blockchainId => _blockchainId;

  void updateBlockchainId(String newId) {
    _blockchainId = newId;
    notifyListeners();
  }

  // Current Location Risk Level
  int _currentRiskLevel = 1; // 1-5 scale
  int get currentRiskLevel => _currentRiskLevel;

  void updateRiskLevel(int level) {
    _currentRiskLevel = level;
    notifyListeners();
  }

  // Emergency Contacts
  List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(
      name: 'Police',
      number: '100',
      type: ContactType.police,
    ),
    EmergencyContact(
      name: 'Ambulance',
      number: '108',
      type: ContactType.medical,
    ),
    EmergencyContact(
      name: 'Fire Service',
      number: '101',
      type: ContactType.fire,
    ),
    EmergencyContact(
      name: 'Tourist Helpline',
      number: '1363',
      type: ContactType.tourist,
    ),
  ];

  List<EmergencyContact> get emergencyContacts => _emergencyContacts;

  void addEmergencyContact(EmergencyContact contact) {
    _emergencyContacts.add(contact);
    notifyListeners();
  }

  // User Status
  UserStatus _userStatus = UserStatus.safe;
  UserStatus get userStatus => _userStatus;

  void updateUserStatus(UserStatus status) {
    _userStatus = status;
    notifyListeners();
  }

  // Chat Messages for AI Assistant
  List<ChatMessage> _chatMessages = [];
  List<ChatMessage> get chatMessages => _chatMessages;

  void addChatMessage(ChatMessage message) {
    _chatMessages.add(message);
    notifyListeners();
  }

  void clearChat() {
    _chatMessages.clear();
    notifyListeners();
  }
}

enum UserStatus { safe, caution, danger, emergency }

enum ContactType { police, medical, fire, tourist, custom }

class EmergencyContact {
  final String name;
  final String number;
  final ContactType type;

  EmergencyContact({
    required this.name,
    required this.number,
    required this.type,
  });
}

class ChatMessage {
  final String id;
  final String message;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });
}