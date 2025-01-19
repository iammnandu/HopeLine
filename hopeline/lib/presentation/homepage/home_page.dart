import 'package:flutter/material.dart';
import 'package:hopeline/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:hopeline/features/music/presentation/pages/playlist_screen.dart';
import 'package:hopeline/presentation/homepage/assessment_card.dart';
import 'package:hopeline/presentation/homepage/meditation_card.dart';
import 'package:hopeline/presentation/quiz/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Widget _buildTodayTaskSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Tasks",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text("• Task 1: Complete meditation session", 
              style: Theme.of(context).textTheme.bodyLarge),
          Text("• Task 2: Listen to a playlist", 
              style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildAssessmentSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: AssessmentCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuizSplashScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMeditationSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: MeditationCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MeditationScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTodayTaskSection(context),
            _buildAssessmentSection(context),
            _buildMeditationSection(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildHomeContent(context),
    );
  }
}
