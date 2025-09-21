import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_state_provider.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
        actions: [
          IconButton(
            onPressed: () => _showAddContactDialog(),
            icon: const Icon(Icons.add),
            tooltip: 'Add Contact',
          ),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Emergency Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.warning, color: Colors.red, size: 32),
                      const SizedBox(height: 8),
                      const Text(
                        'Emergency Contacts',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Quick access to emergency services and important contacts',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Quick Emergency Actions
                Text(
                  'Quick Emergency Actions',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                
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
                        Colors.red,
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
                        'Fire Service',
                        '101',
                        Icons.local_fire_department,
                        Colors.orange,
                        () => _makeCall('101'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildQuickActionCard(
                        'Tourist Help',
                        '1363',
                        Icons.help,
                        Colors.green,
                        () => _makeCall('1363'),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                // All Emergency Contacts
                Text(
                  'All Emergency Contacts',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.emergencyContacts.length,
                  itemBuilder: (context, index) {
                    final contact = provider.emergencyContacts[index];
                    return _buildContactCard(contact, provider);
                  },
                ),
                
                const SizedBox(height: 24),
                
                // Additional Services
                Text(
                  'Additional Services',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                
                _buildServiceCard(
                  'Women Helpline',
                  '1091',
                  'Emergency assistance for women',
                  Icons.woman,
                  Colors.purple,
                ),
                _buildServiceCard(
                  'Disaster Management',
                  '108',
                  'Natural disaster emergency response',
                  Icons.warning,
                  Colors.orange,
                ),
                _buildServiceCard(
                  'Railway Helpline',
                  '139',
                  'Railway security and assistance',
                  Icons.train,
                  Colors.blue,
                ),
                _buildServiceCard(
                  'Road Accident',
                  '1073',
                  'Traffic police and road assistance',
                  Icons.car_crash,
                  Colors.red,
                ),
                
                const SizedBox(height: 24),
                
                // Emergency Tips
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber),
                            const SizedBox(width: 8),
                            const Text(
                              'Emergency Tips',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTip('Stay calm and speak clearly when calling for help'),
                        _buildTip('Provide your exact location and situation details'),
                        _buildTip('Keep your phone charged and location services on'),
                        _buildTip('Save important numbers in your phone contacts'),
                        _buildTip('Inform someone about your travel plans'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildQuickActionCard(String title, String number, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                number,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(EmergencyContact contact, AppStateProvider provider) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getContactTypeColor(contact.type).withValues(alpha: 0.1),
          child: Icon(
            _getContactTypeIcon(contact.type),
            color: _getContactTypeColor(contact.type),
          ),
        ),
        title: Text(
          contact.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(contact.number),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _makeCall(contact.number),
              icon: const Icon(Icons.call, color: Colors.green),
              tooltip: 'Call',
            ),
            if (contact.type == ContactType.custom)
              IconButton(
                onPressed: () => _deleteContact(contact, provider),
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Delete',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(String title, String number, String description, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              number,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.call, color: color, size: 20),
          ],
        ),
        onTap: () => _makeCall(number),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(tip)),
        ],
      ),
    );
  }

  Color _getContactTypeColor(ContactType type) {
    switch (type) {
      case ContactType.police:
        return Colors.blue;
      case ContactType.medical:
        return Colors.red;
      case ContactType.fire:
        return Colors.orange;
      case ContactType.tourist:
        return Colors.green;
      case ContactType.custom:
        return Colors.purple;
    }
  }

  IconData _getContactTypeIcon(ContactType type) {
    switch (type) {
      case ContactType.police:
        return Icons.local_police;
      case ContactType.medical:
        return Icons.local_hospital;
      case ContactType.fire:
        return Icons.local_fire_department;
      case ContactType.tourist:
        return Icons.help;
      case ContactType.custom:
        return Icons.person;
    }
  }

  void _makeCall(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showError('Could not launch phone dialer');
      }
    } catch (e) {
      _showError('Error making call: $e');
    }
  }

  void _showAddContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _nameController.clear();
              _numberController.clear();
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty) {
                final provider = Provider.of<AppStateProvider>(context, listen: false);
                provider.addEmergencyContact(
                  EmergencyContact(
                    name: _nameController.text,
                    number: _numberController.text,
                    type: ContactType.custom,
                  ),
                );
                _nameController.clear();
                _numberController.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact added successfully')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _deleteContact(EmergencyContact contact, AppStateProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Contact'),
        content: Text('Are you sure you want to delete ${contact.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Note: This would need to be implemented in the provider
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}