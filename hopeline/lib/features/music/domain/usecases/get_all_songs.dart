import 'package:hopeline/features/music/domain/entities/song.dart';
import 'package:hopeline/features/music/domain/repository/song_repository.dart';

class GetAllSongs {
  final SongRepository repository;

  GetAllSongs({required this.repository});
  
  Future<List<Song>> call() async {
    return await repository.getallSongs();
  }
}
