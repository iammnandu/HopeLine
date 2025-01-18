import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:hopeline/features/music/presentation/pages/music_player_screen.dart';
import 'package:hopeline/features/music/presentation/pages/playlist_screen.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_state.dart';
import 'package:hopeline/presentation/bottomNavBar/widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> pages = [
    MeditationScreen(),
    PlaylistScreen(),
  ];

  BottomNavigationBarItem createBottomNavBarItem(
      {required String assetName,
      required bool isActive,
      required BuildContext context}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        assetName,
        height: 45,
        color: isActive
            ? Theme.of(context).focusColor
            : Theme.of(context).primaryColor,
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
        debugPrint('state name : $state ');
        if (state is NavigationChanged) {
          return pages[state.index];
        }
        return pages[0];
      }),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationChanged) {
          currentIndex = state.index;
        }
        final List<BottomNavigationBarItem> bottomNavItems = [
          createBottomNavBarItem(
              assetName: 'assets/menu_home.png',isActive:  currentIndex == 0,context:  context, ),
          createBottomNavBarItem(
             assetName: 'assets/menu_songs.png',isActive:  currentIndex == 1,context:  context),
        ];

        return BottomNavBar(
          items: bottomNavItems,
          currentIndex: currentIndex,
        );
      }),
    );
  }
}
