import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hopeline/features/meditation/data/models/daily_quote_model.dart';
import 'package:hopeline/features/meditation/data/models/mood_message_model.dart';

abstract class MeditationRemoteDatasource {
  Future<DailyQuoteModel> getDailyQuote();
  Future<MoodMessageModel> getMoodMessage(String mood);
}

class MeditationRemoteDataSourceImpl implements MeditationRemoteDatasource {
  final http.Client client;

  MeditationRemoteDataSourceImpl({required this.client});

  @override
  Future<DailyQuoteModel> getDailyQuote() {
    final response = await client.get(Uri.parse('http://localhost:6000/meditation/dailyQuote'));

    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      return DailyQuoteModel.fromJson(jsonResponse);

    }else{
      throw Exception('Failed to load quote');
    }

  @override
  Future<MoodMessageModel> getMoodMessage(String mood) {
    final response = await client.get(Uri.parse('http://localhost:6000/meditation/myMood/$mood'));

    if(response.statusCode == 200){
      final jsonResponse = json.decode(response.body);
      return MoodMessageModel.fromJson(jsonResponse);

    }else{
      throw Exception('Failed to mood quote');
    }
  }
}
