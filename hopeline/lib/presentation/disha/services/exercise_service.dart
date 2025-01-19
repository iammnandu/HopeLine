
import 'package:shared_preferences/shared_preferences.dart';

class Exercise {
  final String id;
  final String title;
  final String description;
  final int durationMinutes;
  final List<String> steps;
  bool isCompleted;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.durationMinutes,
    required this.steps,
    this.isCompleted = false,
  });
}

class ExerciseService {
  final SharedPreferences _prefs;

  ExerciseService(this._prefs);

  Future<void> markExerciseComplete(String exerciseId) async {
    await _prefs.setBool('exercise_$exerciseId', true);
  }

  bool isExerciseCompleted(String exerciseId) {
    return _prefs.getBool('exercise_$exerciseId') ?? false;
  }

  List<Exercise> getExercises() {
    return [
      Exercise(
        id: 'breathing',
        title: 'Deep Breathing Exercise',
        description: 'A simple but effective technique to reduce stress and cravings',
        durationMinutes: 5,
        steps: [
          'Find a quiet, comfortable place to sit or lie down',
          'Breathe in slowly through your nose for 4 counts',
          'Hold your breath for 4 counts',
          'Exhale slowly through your mouth for 6 counts',
          'Repeat for 5 minutes'
        ],
      ),
      Exercise(
        id: 'meditation',
        title: 'Mindfulness Meditation',
        description: 'Stay present and manage triggering thoughts',
        durationMinutes: 10,
        steps: [
          'Sit in a comfortable position',
          'Focus on your natural breath',
          'Observe thoughts without judgment',
          'Gently return focus to breath when distracted',
          'Continue for 10 minutes'
        ],
      ),
      // Add more exercises as needed
    ];
  }
}