import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/sos_switch_widget.dart';
import '../widgets/blockchain_id_widget.dart';
import '../widgets/risk_level_indicator.dart';
import 'blockchain_screen.dart';
import 'sos_screen.dart';
import 'geofencing_screen.dart';
import 'ai_chat_screen.dart';
import 'emergency_contacts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const BlockchainScreen(),
    const SOSScreen(),
    const GeofencingScreen(),
    const AIChatScreen(),
    const EmergencyContactsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.shield_outlined, color: Colors.white),
            const SizedBox(width: 8),
            const Text('YatraRakshak'),
          ],
        ),
        actions: [
          Consumer<AppStateProvider>(
            builder: (context, provider, child) {
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(provider.userStatus),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _getStatusText(provider.userStatus),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.security),
            label: 'Blockchain ID',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Geo Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: 'Contacts',
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.safe:
        return Colors.green;
      case UserStatus.caution:
        return Colors.orange;
      case UserStatus.danger:
        return Colors.red;
      case UserStatus.emergency:
        return Colors.red.shade900;
    }
  }

  String _getStatusText(UserStatus status) {
    switch (status) {
      case UserStatus.safe:
        return 'SAFE';
      case UserStatus.caution:
        return 'CAUTION';
      case UserStatus.danger:
        return 'DANGER';
      case UserStatus.emergency:
        return 'EMERGENCY';
    }
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: Theme.of(context).primaryColor,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'YatraRakshak',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            'Your Travel Safety Companion',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Stay safe during your travels with blockchain-secured identity, '
                    'real-time location monitoring, and instant emergency assistance.',
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Quick Access Features
          Text(
            'Quick Access',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          
          // SOS Switch
          const SOSSwitchWidget(),
          
          const SizedBox(height: 16),
          
          // Blockchain ID Display
          const BlockchainIdWidget(),
          
          const SizedBox(height: 16),
          
          // Current Risk Level
          const RiskLevelIndicator(),
          
          const SizedBox(height: 20),
          
          // Feature Grid
          Text(
            'Safety Features',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
            children: [
              _buildFeatureCard(
                context,
                'Geo Fencing',
                'High alert area warnings',
                Icons.location_on,
                Colors.orange,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GeofencingScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'AI Assistant',
                'Smart travel guidance',
                Icons.chat,
                Colors.blue,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AIChatScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'Emergency Contacts',
                'Quick access to help',
                Icons.phone,
                Colors.red,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EmergencyContactsScreen()),
                ),
              ),
              _buildFeatureCard(
                context,
                'Blockchain ID',
                'Secure identity verification',
                Icons.security,
                Colors.green,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const BlockchainScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 32),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}