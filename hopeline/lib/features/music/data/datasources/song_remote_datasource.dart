import 'dart:convert';
import 'package:hopeline/features/music/data/model/songModel.dart';
import 'package:hopeline/features/music/domain/usecases/get_all_songs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class SongRemoteDatasource {
  Future<List<SongModel>> getAllSongs();
}

class SongRemoteDataSourceImpl implements SongRemoteDatasource {
  final http.Client client;
  
  // Replace this with your computer's IP address when running server locally
  // To find your IP:
  // Windows: Open CMD and type 'ipconfig'
  // Mac/Linux: Open terminal and type 'ifconfig' or 'ip addr'
// Replace with your computer's IP
  static String _baseUrl = dotenv.env['BASE_URL'] ?? '';
  // For Android Emulator, use this instead:
  // static const String _baseUrl = 'http://10.0.2.2:6000';

  SongRemoteDataSourceImpl({required this.client});

@override
Future<List<SongModel>> getAllSongs() async {
  try {
    print('Making HTTP request to: $_baseUrl/songs/all'); // Debug print
    
    final response = await client.get(
      Uri.parse('$_baseUrl/songs/all'),
      headers: {
        'Content-Type': 'application/json',
      },
    ).timeout(
      const Duration(seconds: 15),
      onTimeout: () {
        print('Request timed out'); // Debug print
        throw TimeoutException('Connection timeout while fetching songs');
      },
    );

    print('Response status code: ${response.statusCode}'); // Debug print
    print('Response body: ${response.body}'); // Debug print

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      final songs = jsonResponse.map((song) => SongModel.fromJson(song)).toList();
      print('Successfully parsed ${songs.length} songs'); // Debug print
      return songs;
    } else {
      print('Server returned error status code: ${response.statusCode}'); // Debug print
      throw ServerException(
        'Failed to load songs. Status Code: ${response.statusCode}'
      );
    }
  } catch (e) {
    print('Error in getAllSongs: $e'); // Debug print
    rethrow;
  }
}
}

// Custom exceptions
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
  
  @override
  String toString() => message;
}

class TimeoutException implements Exception {
  final String message;
  TimeoutException(this.message);
  
  @override
  String toString() => message;
}



