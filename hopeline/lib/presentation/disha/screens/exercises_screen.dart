import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guided Exercises'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildExerciseCard(
            context,
            'Breathing Exercise',
            '5 minutes',
            'Calm your mind with deep breathing',
            Icons.air,
          ),
          _buildExerciseCard(
            context,
            'Progressive Relaxation',
            '10 minutes',
            'Release tension from your body',
            Icons.self_improvement,
          ),
          _buildExerciseCard(
            context,
            'Gratitude Journal',
            '15 minutes',
            'Write about things you\'re grateful for',
            Icons.book_outlined,
          ),
          _buildExerciseCard(
            context,
            'Positive Affirmations',
            '5 minutes',
            'Strengthen your resolve',
            Icons.favorite_outline,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    String title,
    String duration,
    String description,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 32.0),
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(duration),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(description),
          ),
          ButtonBar(
            children: [
              TextButton(
                onPressed: () {
                  // Show exercise details
                },
                child: const Text('LEARN MORE'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Start exercise
                },
                child: const Text('START'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}