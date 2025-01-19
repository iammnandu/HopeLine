import 'package:flutter/material.dart';
import 'package:hopeline/presentation/disha/screens/chat_screen.dart';
import 'package:hopeline/presentation/disha/screens/exercises_screen.dart';
import 'package:hopeline/presentation/disha/screens/insights_screen.dart';
import 'package:hopeline/presentation/disha/screens/strategies_screen.dart';

class DishaHomeScreen extends StatefulWidget {
  const DishaHomeScreen({super.key});

  @override
  State<DishaHomeScreen> createState() => DishaHomeScreenState();
}

class DishaHomeScreenState extends State<DishaHomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ChatScreen(),
    const StrategiesScreen(),
    const ExercisesScreen(),
    const InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Support',
          ),
          NavigationDestination(
            icon: Icon(Icons.psychology_outlined),
            selectedIcon: Icon(Icons.psychology),
            label: 'Strategies',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center_outlined),
            selectedIcon: Icon(Icons.fitness_center),
            label: 'Exercises',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Insights',
          ),
        ],
      ),
    );
  }
}