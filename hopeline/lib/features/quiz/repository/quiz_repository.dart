// repository/quiz_repository.dart
import '../models/quiz_question.dart';
import '../services/quiz_service.dart';

class QuizRepository {
  final QuizService _quizService;

  QuizRepository({QuizService? quizService}) 
      : _quizService = quizService ?? QuizService();

  Future<List<QuizQuestion>> getQuestions() async {
    try {
      return await _quizService.getQuestions();
    } catch (e) {
      throw Exception('Failed to fetch questions: $e');
    }
  }
}