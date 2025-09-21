import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class SOSSwitchWidget extends StatelessWidget {
  const SOSSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, provider, child) {
        return Card(
          color: provider.sosEnabled ? Colors.red.shade50 : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: provider.sosEnabled ? Colors.red : Colors.grey,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Emergency SOS',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: provider.sosEnabled ? Colors.red : null,
                        ),
                      ),
                      Text(
                        provider.sosEnabled 
                          ? 'SOS mode active - Emergency services alerted'
                          : 'Tap to activate emergency mode',
                        style: TextStyle(
                          color: provider.sosEnabled ? Colors.red.shade700 : Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.scale(
                  scale: 1.2,
                  child: Switch(
                    value: provider.sosEnabled,
                    onChanged: (value) {
                      provider.toggleSOS();
                      if (value) {
                        _showSOSDialog(context);
                      }
                    },
                    activeThumbColor: Colors.red,
                    activeTrackColor: Colors.red.shade200,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSOSDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              const SizedBox(width: 8),
              const Text('SOS Activated'),
            ],
          ),
          content: const Text(
            'Emergency mode is now active. Your location has been shared with emergency services and your emergency contacts.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}