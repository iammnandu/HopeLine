import 'package:hopeline/features/music/data/datasources/song_remote_datasource.dart';
import 'package:hopeline/features/music/domain/entities/song.dart';
import 'package:hopeline/features/music/domain/repository/song_repository.dart';

class SongRepositoryImpl implements SongRepository {

  final SongRemoteDatasource remoteDataSource;

  SongRepositoryImpl({ required this.remoteDataSource});

  @override
  Future<List<Song>> getallSongs() async {
    final songModels = await remoteDataSource.getAllSongs();
    return songModels;
  }
  
}