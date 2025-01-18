import 'package:hopeline/features/meditation/domain/entities/mood_message.dart';
import 'package:hopeline/features/meditation/domain/repositories/meditation_repository.dart';

class GetMoodMessage {
  final MeditationRepository repository;

  GetMoodMessage({required this.repository});

Future<MoodMessage> call(String mood) async {
  return await repository.getMoodMessage(mood: mood);
}
}
