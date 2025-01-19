import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:hopeline/features/music/presentation/pages/playlist_screen.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_state.dart';
import 'package:hopeline/presentation/bottomNavBar/widgets/bottom_nav_bar.dart';
import 'package:hopeline/presentation/homepage/assessment_card.dart';
import 'package:hopeline/presentation/homepage/meditation_card.dart';
import 'package:hopeline/presentation/homepage/profile_page.dart';
import 'package:hopeline/presentation/quiz/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> pages = [
    MeditationScreen(),
    PlaylistScreen(),
  ];

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Hopeline",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RecoveryProfile(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, 
                          color: Colors.orange[300]),
                      const SizedBox(width: 8),
                      const Text('POINTS'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: 0.75,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green[300]!),
                          strokeWidth: 8,
                        ),
                      ),
                      const Text(
                        '2250',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.local_fire_department, 
                          color: Colors.orange[300]),
                      const SizedBox(width: 8),
                      const Text('PROGRESS'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: 0.8,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.black),
                          strokeWidth: 8,
                        ),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '25',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'STREAKS',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "It is better to conquer yourself than to win a thousand battles",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[600],
                  ),
            ),
          ),
          const SizedBox(width: 16),
          Icon(
            Icons.format_quote,
            size: 32,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

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
            _buildStatsSection(context),
            _buildQuoteSection(context),
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
      appBar: _buildAppBar(context),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationChanged) {
            if (state.index == 0) {
              return _buildHomeContent(context);
            }
            return pages[state.index];
          }
          return _buildHomeContent(context);
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is NavigationChanged) {
            currentIndex = state.index;
          }
          return BottomNavBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Playlist',
              ),
            ],
            currentIndex: currentIndex,
          );
        },
      ),
    );
  }
}