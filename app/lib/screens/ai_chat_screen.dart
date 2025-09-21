import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<String> _quickQuestions = [
    'Is this area safe for tourists?',
    'What are the local emergency numbers?',
    'Best route to avoid high-risk areas?',
    'Travel safety tips for this region',
    'Nearest police station location',
    'Current weather and safety alerts',
  ];

  @override
  void initState() {
    super.initState();
    // Add welcome message if chat is empty
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppStateProvider>(context, listen: false);
      if (provider.chatMessages.isEmpty) {
        _addWelcomeMessage(provider);
      }
    });
  }

  void _addWelcomeMessage(AppStateProvider provider) {
    provider.addChatMessage(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: 'Hello! I\'m your YatraRakshak AI Assistant. I can help you with:\n\n'
            '🛡️ Local safety information\n'
            '📍 Navigation and route planning\n'
            '🚨 Emergency assistance\n'
            '🏥 Finding nearby services\n'
            '🌟 Travel recommendations\n\n'
            'How can I assist you today?',
        isUser: false,
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text('AI Safety Assistant'),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => _clearChat(),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear Chat',
          ),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Chat Messages
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: provider.chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = provider.chatMessages[index];
                    return _buildMessageBubble(message);
                  },
                ),
              ),
              
              // Typing Indicator
              if (_isTyping)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(Icons.smart_toy, color: Colors.blue, size: 16),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: List.generate(3, (index) {
                                  return Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Quick Questions (when chat is empty or minimal)
              if (provider.chatMessages.length <= 1)
                Container(
                  height: 120,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Questions:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _quickQuestions.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ActionChip(
                                label: Text(_quickQuestions[index]),
                                onPressed: () => _sendQuickQuestion(_quickQuestions[index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              
              // Message Input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Ask about safety, directions, or emergency help...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FloatingActionButton.small(
                      onPressed: _sendMessage,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blue.shade100,
              child: Icon(Icons.smart_toy, color: Colors.blue, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser ? Colors.blue : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomLeft: message.isUser ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${message.timestamp.hour}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: message.isUser ? Colors.white70 : Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.green.shade100,
              child: Icon(Icons.person, color: Colors.green, size: 16),
            ),
          ],
        ],
      ),
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    final provider = Provider.of<AppStateProvider>(context, listen: false);
    
    // Add user message
    provider.addChatMessage(
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );

    _messageController.clear();
    _scrollToBottom();
    
    // Simulate AI response
    _simulateAIResponse(message, provider);
  }

  void _sendQuickQuestion(String question) {
    _messageController.text = question;
    _sendMessage();
  }

  void _simulateAIResponse(String userMessage, AppStateProvider provider) {
    setState(() {
      _isTyping = true;
    });

    // Simulate typing delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
      });

      String response = _generateAIResponse(userMessage);
      
      provider.addChatMessage(
        ChatMessage(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: response,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
      
      _scrollToBottom();
    });
  }

  String _generateAIResponse(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    
    if (lowerMessage.contains('safe') || lowerMessage.contains('safety')) {
      return 'Based on your current location, here\'s the safety assessment:\n\n'
          '✅ You\'re in a moderately safe area\n'
          '⚠️ Avoid isolated streets after 9 PM\n'
          '🚔 Police station is 0.3 km away\n'
          '💡 Stay in well-lit, crowded areas\n\n'
          'Would you like specific safety tips for tourists?';
    }
    
    if (lowerMessage.contains('emergency') || lowerMessage.contains('help')) {
      return 'Emergency assistance information:\n\n'
          '🚔 Police: 100\n'
          '🚑 Ambulance: 108\n'
          '🔥 Fire Service: 101\n'
          '🏥 Tourist Helpline: 1363\n\n'
          'Your location has been noted. Do you need immediate assistance?';
    }
    
    if (lowerMessage.contains('route') || lowerMessage.contains('direction')) {
      return 'For safe route planning:\n\n'
          '🗺️ I recommend taking main roads\n'
          '⚠️ Avoid Dharavi area (high risk)\n'
          '✅ Use well-lit public transport\n'
          '📍 Current location is tourist-friendly\n\n'
          'Share your destination for detailed route guidance.';
    }
    
    if (lowerMessage.contains('weather') || lowerMessage.contains('alert')) {
      return 'Current conditions:\n\n'
          '🌤️ Weather: Partly cloudy, 28°C\n'
          '🚨 No active safety alerts\n'
          '🌧️ Light rain expected evening\n'
          '👕 Carry light jacket and umbrella\n\n'
          'Stay updated with local weather alerts.';
    }
    
    if (lowerMessage.contains('hospital') || lowerMessage.contains('medical')) {
      return 'Nearby medical facilities:\n\n'
          '🏥 Mumbai Central Hospital - 0.5 km\n'
          '⚕️ Emergency Ward: Open 24/7\n'
          '📞 Contact: +91-22-xxxx-xxxx\n'
          '🚑 Ambulance available\n\n'
          'Do you need directions or have a medical emergency?';
    }
    
    // Default response
    return 'I understand you\'re asking about "$userMessage". Here\'s what I can help with:\n\n'
        '🛡️ Safety information for your area\n'
        '📍 Navigation and directions\n'
        '🚨 Emergency contacts and procedures\n'
        '🏥 Nearby hospitals and services\n'
        '🌟 Tourist recommendations\n\n'
        'Please ask me something specific, and I\'ll provide detailed assistance!';
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('This will delete all chat messages. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<AppStateProvider>(context, listen: false).clearChat();
              Navigator.pop(context);
              _addWelcomeMessage(Provider.of<AppStateProvider>(context, listen: false));
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}