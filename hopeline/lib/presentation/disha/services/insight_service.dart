
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsightService {
  final SharedPreferences _prefs;
  static const String _soberDateKey = 'sober_date';
  static const String _achievementsKey = 'achievements';

  InsightService(this._prefs);

  Future<void> setSoberDate(DateTime date) async {
    await _prefs.setString(_soberDateKey, date.toIso8601String());
  }

  DateTime? getSoberDate() {
    final dateStr = _prefs.getString(_soberDateKey);
    return dateStr != null ? DateTime.parse(dateStr) : null;
  }

  int getSoberDays() {
    final soberDate = getSoberDate();
    if (soberDate == null) return 0;
    
    final difference = DateTime.now().difference(soberDate);
    return difference.inDays;
  }

  Future<void> addAchievement(String achievement) async {
    final achievements = getAchievements();
    achievements.add('${DateFormat('yyyy-MM-dd').format(DateTime.now())}: $achievement');
    await _prefs.setStringList(_achievementsKey, achievements);
  }

  List<String> getAchievements() {
    return _prefs.getStringList(_achievementsKey) ?? [];
  }

  String getNextMilestone() {
    final days = getSoberDays();
    final milestones = [7, 30, 90, 180, 365];
    
    for (final milestone in milestones) {
      if (days < milestone) {
        final remaining = milestone - days;
        return '$milestone Days Milestone: $remaining days remaining';
      }
    }
    
    return 'Congratulations on ${days} days!';
  }

  double getProgressToNextMilestone() {
    final days = getSoberDays();
    final milestones = [7, 30, 90, 180, 365];
    
    for (var i = 0; i < milestones.length; i++) {
      if (days < milestones[i]) {
        final previousMilestone = i == 0 ? 0 : milestones[i - 1];
        final progress = (days - previousMilestone) / (milestones[i] - previousMilestone);
        return progress;
      }
    }
    
    return 1.0;
  }
}