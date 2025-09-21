import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class BlockchainScreen extends StatelessWidget {
  const BlockchainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blockchain Identity'),
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main ID Card
                Card(
                  elevation: 8,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade600, Colors.blue.shade800],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.security, color: Colors.white, size: 32),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'YatraRakshak Identity Card',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Blockchain ID',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      provider.blockchainId,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'monospace',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: provider.blockchainId));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('ID copied to clipboard'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.copy, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'VERIFIED',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Valid Until: ${_getExpiryDate()}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Blockchain Details
                Text(
                  'Blockchain Details',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                
                _buildDetailCard(
                  'Network',
                  'YatraRakshak Blockchain',
                  Icons.lan,
                  Colors.blue,
                ),
                _buildDetailCard(
                  'Block Height',
                  '1,247,892',
                  Icons.layers,
                  Colors.green,
                ),
                _buildDetailCard(
                  'Transaction Hash',
                  '0x7d4a...8f9e',
                  Icons.tag,
                  Colors.orange,
                ),
                _buildDetailCard(
                  'Gas Used',
                  '21,000 Gas',
                  Icons.local_gas_station,
                  Colors.red,
                ),
                
                const SizedBox(height: 24),
                
                // Travel History
                Text(
                  'Recent Travel Verifications',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                
                _buildTravelHistoryCard(
                  'Mumbai Central Station',
                  'Entry Verified',
                  DateTime.now().subtract(const Duration(hours: 2)),
                  Colors.green,
                ),
                _buildTravelHistoryCard(
                  'Hotel Taj Palace',
                  'Check-in Verified',
                  DateTime.now().subtract(const Duration(hours: 6)),
                  Colors.blue,
                ),
                _buildTravelHistoryCard(
                  'Gateway of India',
                  'Location Verified',
                  DateTime.now().subtract(const Duration(days: 1)),
                  Colors.orange,
                ),
                
                const SizedBox(height: 24),
                
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _regenerateId(context, provider),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Regenerate ID'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _shareId(context, provider.blockchainId),
                        icon: const Icon(Icons.share),
                        label: const Text('Share ID'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          // Handle detail view
        },
      ),
    );
  }

  Widget _buildTravelHistoryCard(String location, String action, DateTime timestamp, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(Icons.check, color: color),
        ),
        title: Text(location),
        subtitle: Text(action),
        trailing: Text(
          '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  String _getExpiryDate() {
    final expiry = DateTime.now().add(const Duration(days: 365));
    return '${expiry.day}/${expiry.month}/${expiry.year}';
  }

  void _regenerateId(BuildContext context, AppStateProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Regenerate Blockchain ID'),
        content: const Text(
          'This will create a new blockchain identity. Your travel history will be preserved but linked to the new ID. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.updateBlockchainId('YR-BC-${DateTime.now().millisecondsSinceEpoch}');
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('New Blockchain ID generated')),
              );
            },
            child: const Text('Regenerate'),
          ),
        ],
      ),
    );
  }

  void _shareId(BuildContext context, String id) {
    Clipboard.setData(ClipboardData(text: id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Blockchain ID copied for sharing')),
    );
  }
}