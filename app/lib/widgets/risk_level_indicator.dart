import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';

class RiskLevelIndicator extends StatelessWidget {
  const RiskLevelIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateProvider>(
      builder: (context, provider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: _getRiskColor(provider.currentRiskLevel),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Current Area Risk Level',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: provider.currentRiskLevel / 5.0,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          _getRiskColor(provider.currentRiskLevel),
                        ),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getRiskColor(provider.currentRiskLevel),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${provider.currentRiskLevel}/5',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  _getRiskDescription(provider.currentRiskLevel),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () => provider.updateRiskLevel(index + 1),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: index < provider.currentRiskLevel 
                            ? _getRiskColor(index + 1)
                            : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: index < provider.currentRiskLevel 
                                ? Colors.white 
                                : Colors.grey.shade600,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getRiskColor(int level) {
    switch (level) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.lightGreen;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.deepOrange;
      case 5:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getRiskDescription(int level) {
    switch (level) {
      case 1:
        return 'Very Safe - Low crime rate, well-patrolled area';
      case 2:
        return 'Safe - Minor incidents possible, stay aware';
      case 3:
        return 'Moderate - Exercise caution, avoid isolated areas';
      case 4:
        return 'High Risk - Stay in groups, be very cautious';
      case 5:
        return 'Danger Zone - Avoid if possible, high crime rate';
      default:
        return 'Unknown risk level';
    }
  }
}