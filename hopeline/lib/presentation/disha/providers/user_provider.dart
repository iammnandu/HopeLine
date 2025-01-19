import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  int _soberDays = 0;
  List<String> _achievements = [];

  String? get userId => _userId;
  int get soberDays => _soberDays;
  List<String> get achievements => _achievements;

  void setUserId(String id) {
    _userId = id;
    notifyListeners();
  }

  void updateSoberDays(int days) {
    _soberDays = days;
    notifyListeners();
  }

  void addAchievement(String achievement) {
    _achievements.add(achievement);
    notifyListeners();
  }
}