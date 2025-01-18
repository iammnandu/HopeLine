import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/features/music/domain/usecases/get_all_songs.dart';
import 'package:hopeline/features/music/presentation/bloc/song_event.dart';
import 'package:hopeline/features/music/presentation/bloc/song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final GetAllSongs getAllSongs;
  
  SongBloc({required this.getAllSongs}) : super(SongInitial()) {
    on<FetchSongs>((event, emit) async {
      print('FetchSongs event received'); // Debug print
      emit(SongLoading());
      try {
        print('Fetching songs from repository...'); // Debug print
        final songs = await getAllSongs();
        print('Songs fetched successfully. Count: ${songs.length}'); // Debug print
        emit(SongLoaded(songs: songs));
      } catch (e) {
        print('Error in SongBloc: $e'); // Debug print
        emit(SongError(message: 'Failed to load songs: $e'));
      }
    });
  }
}