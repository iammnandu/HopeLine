// services/quiz_service.dart
import 'dart:convert';
import '../models/quiz_question.dart';

class QuizService {
  // Mock API response with recovery-focused questions
  Future<Map<String, dynamic>> getRecoveryQuiz() async {
    // Simulating API delay
    await Future.delayed(const Duration(seconds: 1));

    final questions = [
      {
        "id": "1",
        "category": "Self-Assessment",
        "question": "How often do you think about improving your health and well-being?",
        "options": [
          "Never",
          "Sometimes",
          "Often",
          "Every day"
        ],
        "correct_answer": "Every day",
        "explanation": "Regular focus on health and well-being is crucial for recovery."
      },
      {
        "id": "2",
        "category": "Support System",
        "question": "Who do you feel comfortable talking to when you need support?",
        "options": [
          "No one",
          "Only professionals",
          "Close family/friends",
          "Both professionals and loved ones"
        ],
        "correct_answer": "Both professionals and loved ones",
        "explanation": "A diverse support system strengthens your recovery journey."
      },
      {
        "id": "3",
        "category": "Coping Strategies",
        "question": "What healthy activity helps you manage stress the most?",
        "options": [
          "Exercise",
          "Meditation",
          "Creative activities",
          "Talking to others"
        ],
        "correct_answer": "Meditation",
        "explanation": "Finding healthy stress management techniques is essential for recovery."
      },
      {
        "id": "4",
        "category": "Life Goals",
        "question": "What motivates you most in your recovery journey?",
        "options": [
          "Personal health",
          "Family relationships",
          "Career goals",
          "All of the above"
        ],
        "correct_answer": "All of the above",
        "explanation": "Multiple sources of motivation strengthen recovery commitment."
      },
      {
        "id": "5",
        "category": "Self-Awareness",
        "question": "How do you usually respond to triggers?",
        "options": [
          "Avoid thinking about them",
          "Seek immediate support",
          "Use learned coping strategies",
          "Practice mindfulness"
        ],
        "correct_answer": "Use learned coping strategies",
        "explanation": "Having effective strategies for triggers is crucial for sustained recovery."
      },
      {
        "id": "6",
        "category": "Daily Routine",
        "question": "How structured is your daily routine?",
        "options": [
          "No routine",
          "Somewhat structured",
          "Mostly structured",
          "Very structured"
        ],
        "correct_answer": "Very structured",
        "explanation": "A structured routine provides stability and supports recovery."
      },
      {
        "id": "7",
        "category": "Physical Health",
        "question": "How often do you engage in physical exercise?",
        "options": [
          "Rarely",
          "1-2 times per week",
          "3-4 times per week",
          "Daily"
        ],
        "correct_answer": "3-4 times per week",
        "explanation": "Regular exercise improves both physical and mental well-being."
      },
      {
        "id": "8",
        "category": "Emotional Well-being",
        "question": "How do you handle difficult emotions?",
        "options": [
          "Suppress them",
          "Talk to someone",
          "Write them down",
          "Use healthy coping mechanisms"
        ],
        "correct_answer": "Use healthy coping mechanisms",
        "explanation": "Healthy emotional management is key to recovery."
      },
      {
        "id": "9",
        "category": "Future Planning",
        "question": "How often do you set goals for your future?",
        "options": [
          "Never",
          "Occasionally",
          "Monthly",
          "Weekly"
        ],
        "correct_answer": "Weekly",
        "explanation": "Regular goal-setting helps maintain focus and motivation."
      },
      {
        "id": "10",
        "category": "Social Connection",
        "question": "How often do you participate in support group meetings?",
        "options": [
          "Never",
          "Occasionally",
          "Weekly",
          "Multiple times per week"
        ],
        "correct_answer": "Weekly",
        "explanation": "Regular support group participation strengthens recovery."
      }
    ];

    return {
      "response_code": 0,
      "results": questions,
    };
  }

  // Function to parse response and return List of QuizQuestion objects
  Future<List<QuizQuestion>> getQuestions() async {
    final response = await getRecoveryQuiz();
    
    if (response['response_code'] == 0) {
      return (response['results'] as List)
          .map((question) => QuizQuestion.fromJson(question))
          .toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}