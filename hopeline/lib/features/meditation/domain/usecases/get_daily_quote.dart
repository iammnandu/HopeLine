import 'package:hopeline/features/meditation/domain/entities/daily_quote.dart';
import 'package:hopeline/features/meditation/domain/repositories/meditation_repository.dart';

class GetDailyQuote {
  final MeditationRepository repository;

  GetDailyQuote({required this.repository});

  Future<DailyQuote> call() async {
    return repository.getDailyQuote();
  }
}
