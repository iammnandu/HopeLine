import 'package:flutter/material.dart';

class RecoveryProfile extends StatelessWidget {
  const RecoveryProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('PROFILE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Avatar
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.cyan,
                child: Image.asset('assets/profile.jpeg'), // Replace with your avatar image
              ),
              const SizedBox(height: 16),
              
              // Username
              const Text(
                'Luttappy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              
              // Recovery Journey Text
              const Text(
                'Recovery Journey: 20 days',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat('20', 'Days'),
                  _buildDivider(),
                  _buildStat('5', 'Milestones'),
                  _buildDivider(),
                  _buildStat('2250', 'Points'),
                ],
              ),
              const SizedBox(height: 32),
              
              // Daily Goals Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daily Goal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildDailyGoals(),
              const SizedBox(height: 32),
              
              // Recovery Metrics Section
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Daily Recovery Metrics',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildRecoveryMetrics(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildDailyGoals() {
    final goals = [
      {'icon': Icons.access_time, 'label': 'Mindfulness', 'color': Colors.blue},
      {'icon': Icons.group, 'label': 'Support Group', 'color': Colors.green},
      {'icon': Icons.favorite, 'label': 'Self-Care', 'color': Colors.yellow},
      {'icon': Icons.check_circle, 'label': 'Check-in', 'color': Colors.purple},
      {'icon': Icons.star, 'label': 'Activities', 'color': Colors.red},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: goals.map((goal) => _buildGoalItem(
        icon: goal['icon'] as IconData,
        label: goal['label'] as String,
        color: goal['color'] as Color,
      )).toList(),
    );
  }

  Widget _buildGoalItem({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRecoveryMetrics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMetricItem(
          icon: Icons.sentiment_satisfied_alt,
          label: 'Mood',
          value: 'Positive',
          color: Colors.amber,
        ),
        _buildMetricItem(
          icon: Icons.warning_rounded,
          label: 'Triggers',
          value: 'Low',
          color: Colors.green,
        ),
        _buildMetricItem(
          icon: Icons.fitness_center,
          label: 'Support',
          value: 'Strong',
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}