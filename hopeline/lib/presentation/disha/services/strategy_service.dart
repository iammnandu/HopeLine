class Strategy {
  final String id;
  final String title;
  final String description;
  final List<String> steps;
  final String category;

  Strategy({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.category,
  });
}

class StrategyService {
  List<Strategy> getStrategies() {
    return [
      Strategy(
        id: 'urge_surfing',
        title: 'Urge Surfing',
        description: 'A technique to cope with cravings by observing them without acting',
        category: 'Coping Skills',
        steps: [
          'Notice the urge without trying to fight it',
          'Observe physical sensations in your body',
          'Remember that urges are temporary',
          'Wait it out - urges typically last 20-30 minutes',
          'Celebrate each time you successfully surf an urge'
        ],
      ),
      Strategy(
        id: 'trigger_management',
        title: 'Trigger Management',
        description: 'Identify and plan for triggering situations',
        category: 'Prevention',
        steps: [
          'List known triggers',
          'Rate each trigger\'s intensity',
          'Develop specific plans for each trigger',
          'Practice avoidance when possible',
          'Have backup plans ready'
        ],
      ),
      // Add more strategies as needed
    ];
  }
}