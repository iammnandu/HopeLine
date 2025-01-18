import 'package:hopeline/features/meditation/domain/entities/mood_message.dart';

abstract class MeditationState {}

class MeditationInitial extends MeditationState {}

class MeditationLoading extends MeditationState {}

class MeditationError extends MeditationState {
  final String message;
  MeditationError({required String message});
}

class DailyQuoteLoaded extends MeditationState {
  final String dailyQuote;

  DailyQuoteLoaded({required this.dailyQuote});
}

class MoodMessageLoaded extends MeditationState {
  final MoodMessage moodMessage;

  MoodMessageLoaded({required this.moodMessage});
  
}
