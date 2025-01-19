import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hopeline/features/quiz/const/colors.dart';
import 'package:hopeline/features/quiz/repository/quiz_repository.dart';
import 'package:hopeline/features/quiz/models/quiz_question.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var currentQuestionIndex = 0;
  int seconds = 20;
  Timer? timer;
  late Future<List<QuizQuestion>> quiz;
  var isLoaded = false;
  int points = 0;
  var optionsList = [];
  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  final QuizRepository _quizRepository = QuizRepository();

  @override
  void initState() {
    super.initState();
    quiz = _quizRepository.getQuestions();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
    timer?.cancel();
    seconds = 60;
    startTimer();
  }

  void showResultDialog(List<QuizQuestion> questions) {
    timer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Assessment Complete!',
            style: TextStyle(color: blue, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your score: $points points',
                style: const TextStyle(fontSize: 18, color: darkBlue),
              ),
              const SizedBox(height: 16),
              const Text(
                'Remember, this assessment is a tool for self-reflection. Your honest answers help guide your recovery journey.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Continue Journey',
                style: TextStyle(color: blue, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Return to previous screen
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [blue, darkBlue],
          ),
        ),
        child: FutureBuilder<List<QuizQuestion>>(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot<List<QuizQuestion>> snapshot) {
            if (snapshot.hasData) {
              var questions = snapshot.data!;

              // Check if we've reached the end of questions
              if (currentQuestionIndex >= questions.length) {
                Future.microtask(() => showResultDialog(questions));
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }

              var currentQuestion = questions[currentQuestionIndex];

              if (isLoaded == false) {
                optionsList = currentQuestion.options;
                isLoaded = true;
              }

              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: lightgrey, width: 2),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.xmark,
                                color: Colors.white,
                                size: 23,
                              ),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Text(
                                "$seconds",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  value: seconds / 60,
                                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Image.asset("assets/images/ideas.png", width: 100),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          currentQuestion.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Question ${currentQuestionIndex + 1} of ${questions.length}",
                          style: const TextStyle(
                            color: lightgrey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        currentQuestion.question,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: optionsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (optionsList[index] == currentQuestion.correctAnswer) {
                                  optionsColor[index] = const Color.fromARGB(255, 76, 175, 145);
                                  points = points + 10;
                                } else {
                                  optionsColor[index] = const Color.fromARGB(255, 234, 201, 50);
                                }

                                // Show explanation in a snackbar
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(currentQuestion.explanation),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor: blue,
                                  ),
                                );

                                if (currentQuestionIndex < questions.length - 1) {
                                  Future.delayed(const Duration(seconds: 2), () {
                                    gotoNextQuestion();
                                  });
                                } else {
                                  Future.delayed(const Duration(seconds: 2), () {
                                    showResultDialog(questions);
                                  });
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: size.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                optionsList[index],
                                style: TextStyle(
                                  color: optionsColor[index] == Colors.white ? blue : Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error loading questions: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}