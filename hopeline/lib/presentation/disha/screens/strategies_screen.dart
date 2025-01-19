import 'package:flutter/material.dart';

class StrategiesScreen extends StatelessWidget {
  const StrategiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalized Strategies'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildStrategyCard(
            context,
            'Mindfulness Techniques',
            'Practice being present in the moment',
            Icons.spa,
          ),
          _buildStrategyCard(
            context,
            'Trigger Management',
            'Identify and handle triggering situations',
            Icons.warning_outlined,
          ),
          _buildStrategyCard(
            context,
            'Healthy Routines',
            'Establish daily routines for recovery',
            Icons.schedule,
          ),
          _buildStrategyCard(
            context,
            'Support Network',
            'Connect with supportive people',
            Icons.people_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildStrategyCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Icon(icon, size: 32.0),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Navigate to detailed strategy screen
        },
      ),
    );
  }
}