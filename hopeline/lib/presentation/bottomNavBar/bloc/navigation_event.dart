abstract class NavigationEvent {}

class NavigationTo extends NavigationEvent {
  final int index;

  NavigationTo({required this.index});
}