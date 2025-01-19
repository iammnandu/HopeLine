import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_event.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_state.dart';
import 'package:hopeline/presentation/bottomNavBar/widgets/bottom_nav_bar.dart';
import 'package:hopeline/presentation/community/community_page.dart';
import 'package:hopeline/presentation/disha/screens/disha_home_screen.dart';
import 'package:hopeline/presentation/homepage/home_page.dart';
import 'package:hopeline/features/meditation/presentation/pages/meditation_screen.dart';
import 'package:hopeline/features/music/presentation/pages/playlist_screen.dart';
import 'package:hopeline/presentation/homepage/profile_page.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _pages = [
    HomeScreen(),
     WellnessHubCommunity(),
    PlaylistScreen(),
    const DishaHomeScreen(),
  ];

  final List<String> _titles = [
    'Hopeline',
    'Community',
    'Playlist',
    'Profile'
  ];

  PreferredSizeWidget _buildAppBar(BuildContext context, int currentIndex) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        _titles[currentIndex],
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      leading: Image.asset('assets/menu_burger.png'),
      actions: [
        GestureDetector(
        onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RecoveryProfile(),
          ),
        );
      },



          child: const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile.jpeg'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationChanged) {
          currentIndex = state.index;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context, currentIndex),
          body: SafeArea(
            child: _pages[currentIndex],
          ),
          bottomNavigationBar: BottomNavBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.music_note),
                label: 'Playlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chat',
              ),
            ],
            currentIndex: currentIndex,
          ),
        );
      },
    );
  }
}