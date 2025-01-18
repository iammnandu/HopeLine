import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hopeline/core/theme.dart';
import 'package:hopeline/features/music/presentation/bloc/song_bloc.dart';
import 'package:hopeline/features/music/presentation/bloc/song_event.dart';
import 'package:hopeline/features/music/presentation/bloc/song_state.dart';
import 'package:hopeline/features/music/presentation/pages/music_player_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class PlaylistScreen extends StatefulWidget {
  PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  static const String defaultThumbnail = 'assets/child_with_dog.png';
  final  String _baseUrl = dotenv.env['BASE_URL'] ?? '';

  @override
  void initState() {
    super.initState();
    print('Dispatching FetchSongs event');
    context.read<SongBloc>().add(FetchSongs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chill Playlist',
            style: Theme.of(context).textTheme.titleMedium),
        backgroundColor: DefaultColors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: BlocBuilder<SongBloc, SongState>(
        builder: (context, state) {
          print('Current state: $state'); // Debug print

          if (state is SongLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SongLoaded) {
            print('Songs loaded: ${state.songs.length}'); // Debug print
            return Container(
              color: DefaultColors.white,
              child: state.songs.isEmpty
                  ? Center(
                      child: Text('No songs available',
                          style: Theme.of(context).textTheme.labelSmall))
                  : ListView.builder(
                      itemCount: state.songs.length,
                      itemBuilder: (context, index) {
                        final song = state.songs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(defaultThumbnail),
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 15),
                          title: Text(song.title,
                              style: Theme.of(context).textTheme.labelMedium),
                          subtitle: Text(song.artist,
                              style: Theme.of(context).textTheme.labelSmall),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicPlayerScreen(
                                        song: state.songs[index],
                                      )),
                            );
                          },
                        );
                      },
                    ),
            );
          } else if (state is SongError) {
            print('Error state: ${state.message}'); // Debug print
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message,
                    style: Theme.of(context).textTheme.labelSmall),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<SongBloc>().add(FetchSongs());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('Testing API connection...'); // Debug print
          final client = http.Client();
          try {
            print('Making test request to: $_baseUrl/songs/all');
            final response = await client.get(Uri.parse('$_baseUrl/songs/all'));
            print('Test response status: ${response.statusCode}');
            print('Test response body: ${response.body}');
          } catch (e) {
            print('Test error: $e');
          } finally {
            client.close();
          }
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
