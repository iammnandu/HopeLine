import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_bloc.dart';
import 'package:hopeline/presentation/bottomNavBar/bloc/navigation_event.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  const BottomNavBar(
      {super.key, required this.items, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: (index) {
        context.read<NavigationBloc>().add(NavigationTo(index: index));
      },
    );
  }
}
