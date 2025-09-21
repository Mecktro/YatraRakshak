import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class GeofencingScreen extends StatefulWidget {
  const GeofencingScreen({super.key});

  @override
  State<GeofencingScreen> createState() => _GeofencingScreenState();
}

class _GeofencingScreenState extends State<GeofencingScreen> {
  final List<GeofenceArea> _geofenceAreas = [
    GeofenceArea(
      name: 'Mumbai Central Station',
      riskLevel: 3,
      distance: 0.2,
      alertType: AlertType.medium,
      description: 'Crowded area, pickpocketing incidents reported',
      coordinates: '19.0633, 72.8318',
    ),
    GeofenceArea(
      name: 'Dharavi Slums',
      riskLevel: 5,
      distance: 0.8,
      alertType: AlertType.high,
      description: 'High crime area, avoid after dark',
      coordinates: '19.0450, 72.8553',
    ),
    GeofenceArea(
      name: 'Gateway of India',
      riskLevel: 2,
      distance: 1.2,
      alertType: AlertType.low,
      description: 'Tourist area, generally safe with police presence',
      coordinates: '18.9220, 72.8347',
    ),
    GeofenceArea(
      name: 'Colaba Market',
      riskLevel: 3,
      distance: 0.5,
      alertType: AlertType.medium,
      description: 'Busy market, watch for overcharging and theft',
      coordinates: '18.9067, 72.8147',
    ),
    GeofenceArea(
      name: 'Juhu Beach',
      riskLevel: 1,
      distance: 2.1,
      alertType: AlertType.safe,
      description: 'Safe tourist area with lifeguards',
      coordinates: '19.0968, 72.8267',
    ),
  ];

  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'High Risk', 'Medium Risk', 'Safe Areas'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geo-Fencing Alerts'),
        actions: [
          IconButton(
            onPressed: () => _showMapView(),
            icon: const Icon(Icons.map),
            tooltip: 'Map View',
          ),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Current Location Status
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: _getCurrentLocationColor(provider.currentRiskLevel),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current Location Status',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _getCurrentLocationDescription(provider.currentRiskLevel),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Level ${provider.currentRiskLevel}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Filter Options
              Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filterOptions.length,
                  itemBuilder: (context, index) {
                    final option = _filterOptions[index];
                    final isSelected = _selectedFilter == option;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(option),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedFilter = option;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Geofence Areas List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _getFilteredAreas().length,
                  itemBuilder: (context, index) {
                    final area = _getFilteredAreas()[index];
                    return _buildGeofenceCard(area);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addCustomGeofence(),
        tooltip: 'Add Custom Alert Area',
        child: const Icon(Icons.add_location),
      ),
    );
  }

  Widget _buildGeofenceCard(GeofenceArea area) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _getAlertColor(area.alertType),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    area.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getAlertColor(area.alertType).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Risk ${area.riskLevel}/5',
                    style: TextStyle(
                      color: _getAlertColor(area.alertType),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              area.description,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text(
                  '${area.distance} km away',
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      size: 16,
                      color: index < area.riskLevel 
                        ? _getAlertColor(area.alertType)
                        : Colors.grey.shade300,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _viewOnMap(area),
                    icon: const Icon(Icons.map, size: 16),
                    label: const Text('View on Map'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _setAlert(area),
                    icon: const Icon(Icons.notifications, size: 16),
                    label: const Text('Set Alert'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getAlertColor(area.alertType),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<GeofenceArea> _getFilteredAreas() {
    if (_selectedFilter == 'All') return _geofenceAreas;
    if (_selectedFilter == 'High Risk') {
      return _geofenceAreas.where((area) => area.riskLevel >= 4).toList();
    }
    if (_selectedFilter == 'Medium Risk') {
      return _geofenceAreas.where((area) => area.riskLevel == 2 || area.riskLevel == 3).toList();
    }
    if (_selectedFilter == 'Safe Areas') {
      return _geofenceAreas.where((area) => area.riskLevel == 1).toList();
    }
    return _geofenceAreas;
  }

  Color _getAlertColor(AlertType type) {
    switch (type) {
      case AlertType.safe:
        return Colors.green;
      case AlertType.low:
        return Colors.lightGreen;
      case AlertType.medium:
        return Colors.orange;
      case AlertType.high:
        return Colors.red;
    }
  }

  Color _getCurrentLocationColor(int riskLevel) {
    if (riskLevel <= 2) return Colors.green;
    if (riskLevel == 3) return Colors.orange;
    return Colors.red;
  }

  String _getCurrentLocationDescription(int riskLevel) {
    if (riskLevel <= 2) return 'You are in a safe area';
    if (riskLevel == 3) return 'Exercise caution in this area';
    return 'You are in a high-risk area';
  }

  void _viewOnMap(GeofenceArea area) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${area.name} - Map View'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 48, color: Colors.grey.shade400),
                    const SizedBox(height: 8),
                    Text('Map integration coming soon'),
                    Text('Coordinates: ${area.coordinates}'),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _setAlert(GeofenceArea area) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Alert set for ${area.name}'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _addCustomGeofence() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Alert Area'),
        content: const Text('Custom geofence creation will be available in the next update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showMapView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Geofence Map')),
          body: const Center(
            child: Text('Map integration coming soon'),
          ),
        ),
      ),
    );
  }
}

enum AlertType { safe, low, medium, high }

class GeofenceArea {
  final String name;
  final int riskLevel;
  final double distance;
  final AlertType alertType;
  final String description;
  final String coordinates;

  GeofenceArea({
    required this.name,
    required this.riskLevel,
    required this.distance,
    required this.alertType,
    required this.description,
    required this.coordinates,
  });
}