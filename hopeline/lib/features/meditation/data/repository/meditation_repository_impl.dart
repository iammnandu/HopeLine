import 'package:hopeline/features/meditation/data/datasources/meditation_remote_datasource.dart';
import 'package:hopeline/features/meditation/domain/entities/daily_quote.dart';
import 'package:hopeline/features/meditation/domain/entities/mood_message.dart';
import 'package:hopeline/features/meditation/domain/repositories/meditation_repository.dart';

class MeditationRepositoryImpl implements MeditationRepository {

  final MeditationRemoteDatasource remoteDatasource;

  MeditationRepositoryImpl({required this.remoteDatasource});

  @override
  Future<DailyQuote> getDailyQuote() async {
    return await remoteDatasource.getDailyQuote();
  }

  @override
  Future<MoodMessage> getMoodMessage({required String mood})  async {
    return await remoteDatasource.getMoodMessage(mood);
  }

}
