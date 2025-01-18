import 'package:flutter/material.dart';
import 'package:hopeline/core/theme.dart';
import 'package:hopeline/features/meditation/presentation/widgets/feeling_button.dart';
import 'package:hopeline/features/meditation/presentation/widgets/task_card.dart';

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Image.asset('assets/menu_burger.png'),
          actions: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            const SizedBox(width: 16),
          ]),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back, Sabrina',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 32),
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FeelingButton(
                      label: 'Happy',
                      image: 'assets/happy.png',
                      color: DefaultColors.pink),
                  FeelingButton(
                      label: 'Calm',
                      image: 'assets/calm.png',
                      color: DefaultColors.purple),
                  FeelingButton(
                      label: 'Relax',
                      image: 'assets/relax.png',
                      color: DefaultColors.orange),
                  FeelingButton(
                      label: 'Focus',
                      image: 'assets/focus.png',
                      color: DefaultColors.lightteal),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Todays\'s Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              TaskCard(
                title: 'Morning',
                description:
                    'Let\'s open up to the thing that matter among the People',
                color: DefaultColors.task1,
              ),
              SizedBox(height: 16),
              TaskCard(
                title: 'Noon',
                description:
                    'Let\'s open up to the thing that matter among the People',
                color: DefaultColors.task2,
              ),
              SizedBox(height: 16),
              TaskCard(
                title: 'Evening',
                description:
                    'Let\'s open up to the thing that matter among the People',
                color: DefaultColors.task3,
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
