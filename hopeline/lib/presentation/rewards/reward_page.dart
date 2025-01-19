import 'package:flutter/material.dart';

class Reward {
  final String name;
  final String description;
  final int points;
  final IconData icon;

  const Reward({
    required this.name, 
    required this.description, 
    required this.points,
    required this.icon,
  });
}

class RewardsPage extends StatelessWidget {
  final int currentPoints;

  const RewardsPage({
    super.key,
    required this.currentPoints,
  });

  final List<Reward> rewards = const [
    Reward(
      name: 'Premium Meditation',
      description: 'Unlock a premium meditation session',
      points: 1000,
      icon: Icons.self_improvement,
    ),
    Reward(
      name: 'Custom Playlist',
      description: 'Create your own custom playlist',
      points: 1500,
      icon: Icons.playlist_add,
    ),
    Reward(
      name: 'Exclusive Theme',
      description: 'Unlock a special app theme',
      points: 2000,
      icon: Icons.palette,
    ),
    Reward(
      name: 'Personal Coach',
      description: '30-minute session with a wellness coach',
      points: 5000,
      icon: Icons.person,
    ),
  ];

  Widget _buildPointsHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.blue[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Available Points',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentPoints.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, Reward reward) {
    final bool canRedeem = currentPoints >= reward.points;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          reward.icon,
          size: 36,
          color: canRedeem ? Colors.blue : Colors.grey,
        ),
        title: Text(
          reward.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(reward.description),
            const SizedBox(height: 8),
            Text(
              '${reward.points} points',
              style: TextStyle(
                color: canRedeem ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: canRedeem
              ? () {
                  _showRedeemDialog(context, reward);
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canRedeem ? Colors.blue : Colors.grey,
          ),
          child: const Text('Redeem'),
        ),
      ),
    );
  }

  void _showRedeemDialog(BuildContext context, Reward reward) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redeem Reward'),
        content: Text(
          'Are you sure you want to redeem ${reward.name} for ${reward.points} points?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement reward redemption logic
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Successfully redeemed ${reward.name}!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rewards'),
      ),
      body: ListView(
        children: [
          _buildPointsHeader(context),
          ...rewards.map((reward) => _buildRewardCard(context, reward)),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}