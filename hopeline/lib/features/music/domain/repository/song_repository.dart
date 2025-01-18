import 'package:hopeline/features/music/domain/entities/song.dart';

abstract class SongRepository {
  Future<List<Song>>getallSongs();
  
}
