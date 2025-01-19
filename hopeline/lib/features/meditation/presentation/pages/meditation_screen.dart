import 'package:flutter/material.dart';
import 'package:hopeline/core/theme.dart';
import 'package:hopeline/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:hopeline/features/meditation/presentation/widgets/task_card.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back, Sabrina',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 32),
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FeelingButton(
                      label: 'Happy',
                      image: 'assets/happy.png',
                      color: DefaultColors.pink,
                    ),
                    const SizedBox(width: 12),
                    FeelingButton(
                      label: 'Calm',
                      image: 'assets/calm.png',
                      color: DefaultColors.purple,
                    ),
                    const SizedBox(width: 12),
                    FeelingButton(
                      label: 'Relax',
                      image: 'assets/relax.png',
                      color: DefaultColors.orange,
                    ),
                    const SizedBox(width: 12),
                    FeelingButton(
                      label: 'Focus',
                      image: 'assets/focus.png',
                      color: DefaultColors.lightteal,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Today\'s Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              TaskCard(
                title: 'Morning',
                description:
                    'Let\'s open up to the thing that matter among the People',
                color: DefaultColors.task1,
              ),
              const SizedBox(height: 16),
              TaskCard(
                title: 'Noon',
                description:
                    'Let\'s open up to the thing that matter among the People',
                color: DefaultColors.task2,
              ),
              const SizedBox(height: 16),
              TaskCard(
                title: 'Evening',
                description:
                    'Let\'s open up to the thing that matter among the People',
                color: DefaultColors.task3,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}