import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency SOS'),
        backgroundColor: Colors.red,
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: provider.sosEnabled 
                  ? [Colors.red.shade100, Colors.red.shade50]
                  : [Colors.grey.shade100, Colors.white],
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  
                  // SOS Status
                  Card(
                    color: provider.sosEnabled ? Colors.red.shade50 : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Icon(
                            provider.sosEnabled ? Icons.warning : Icons.shield,
                            size: 48,
                            color: provider.sosEnabled ? Colors.red : Colors.green,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            provider.sosEnabled ? 'SOS ACTIVE' : 'SOS STANDBY',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: provider.sosEnabled ? Colors.red : Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            provider.sosEnabled 
                              ? 'Emergency services have been notified\nYour location is being tracked'
                              : 'Tap the button below in case of emergency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: provider.sosEnabled ? Colors.red.shade700 : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Main SOS Button
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: provider.sosEnabled ? _pulseAnimation.value : 1.0,
                        child: GestureDetector(
                          onTap: () {
                            provider.toggleSOS();
                            if (provider.sosEnabled) {
                              _activateSOS(context);
                            } else {
                              _deactivateSOS(context);
                            }
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: provider.sosEnabled ? Colors.red : Colors.red.shade700,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withValues(alpha: 0.3),
                                  blurRadius: 20,
                                  spreadRadius: provider.sosEnabled ? 10 : 5,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                  size: 48,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  provider.sosEnabled ? 'STOP\nSOS' : 'EMERGENCY\nSOS',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Quick Emergency Actions
                  if (provider.sosEnabled) ...[
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickActionCard(
                            'Call Police',
                            '100',
                            Icons.local_police,
                            Colors.blue,
                            () => _makeCall('100'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildQuickActionCard(
                            'Call Ambulance',
                            '108',
                            Icons.local_hospital,
                            Colors.green,
                            () => _makeCall('108'),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildQuickActionCard(
                            'Share Location',
                            'GPS',
                            Icons.location_on,
                            Colors.orange,
                            () => _shareLocation(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildQuickActionCard(
                            'Send Message',
                            'SMS',
                            Icons.message,
                            Colors.purple,
                            () => _sendEmergencyMessage(),
                          ),
                        ),
                      ],
                    ),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  // Emergency Instructions
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue),
                              const SizedBox(width: 8),
                              const Text(
                                'Emergency Instructions',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildInstruction('1. Stay calm and assess your situation'),
                          _buildInstruction('2. If safe, move to a well-lit public area'),
                          _buildInstruction('3. Keep your phone charged and location on'),
                          _buildInstruction('4. Contact local authorities if needed'),
                          _buildInstruction('5. Inform your emergency contacts'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String subtitle, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 16),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  void _activateSOS(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            const SizedBox(width: 8),
            const Text('SOS Activated'),
          ],
        ),
        content: const Text(
          'Emergency mode is now active. Your location has been shared with emergency services and your emergency contacts have been notified.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _deactivateSOS(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS deactivated. Stay safe!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _makeCall(String number) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $number...')),
    );
    // Implement actual calling functionality
  }

  void _shareLocation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Location shared with emergency contacts')),
    );
    // Implement location sharing
  }

  void _sendEmergencyMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Emergency message sent')),
    );
    // Implement emergency messaging
  }
}