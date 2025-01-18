import 'package:flutter/material.dart';
import 'package:hopeline/features/music/domain/entities/song.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MusicPlayerScreen extends StatefulWidget {
  final Song song;
  const MusicPlayerScreen({super.key, required this.song});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool isLooping = false;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    try {
      // Request permissions first
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission denied');
      }

      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final localPath = await _getLocalAudioPath();
      final file = File(localPath);

      if (!await file.exists()) {
        await _downloadAudioFile(file);
      }

      await _audioPlayer.setFilePath(localPath);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Error: ${e.toString()}';
      });
      print('Error initializing audio: $e');
    }
  }

  Future<String> _getLocalAudioPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = widget.song.songLink.split('/').last;
    return '${directory.path}/$fileName';
  }

  Future<void> _downloadAudioFile(File file) async {
    try {
      // Construct the full URL using your server's base URL
      final String baseUrl = dotenv.env['BASE_URL'] ?? '';

      final fullUrl = '$baseUrl${widget.song.songLink}';

      final response = await http.get(Uri.parse(fullUrl));

      if (response.statusCode != 200) {
        throw Exception('Failed to download file: ${response.statusCode}');
      }

      await file.writeAsBytes(response.bodyBytes);
    } catch (e) {
      throw Exception('Download failed: ${e.toString()}');
    }
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }

  void seekBackward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition - const Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition >= Duration.zero ? newPosition : Duration.zero);
  }

  void seekForward() {
    final currentPosition = _audioPlayer.position;
    final newPosition = currentPosition + const Duration(seconds: 10);
    _audioPlayer.seek(newPosition);
  }

  void toggleLoop() {
    setState(() {
      isLooping = !isLooping;
      _audioPlayer.setLoopMode(isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  void seekRestart() {
    _audioPlayer.seek(Duration.zero);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Image.asset('assets/down_arrow.png'),
          onTap: () => Navigator.of(context).pop(),
        ),
        actions: [
          Image.asset('assets/transcript_icon.png'),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Show loading or error state
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(errorMessage!,
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _initializeAudio,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    // Artwork
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/child_with_dog.png',
                        height: screenHeight * 0.4,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Title
                    Text(
                      widget.song.title,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Artist
                    Text(
                      'By: ${widget.song.artist}',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Progress Bar
                    StreamBuilder<Duration>(
                      stream: _audioPlayer.positionStream,
                      builder: (context, snapshot) {
                        final position = snapshot.data ?? Duration.zero;
                        final total = _audioPlayer.duration ?? Duration.zero;

                        return ProgressBar(
                          progress: position,
                          total: total,
                          onSeek: (duration) {
                            _audioPlayer.seek(duration);
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.shuffle),
                        ),
                        IconButton(
                          onPressed: seekBackward,
                          icon: const Icon(Icons.skip_previous),
                        ),
                        StreamBuilder<PlayerState>(
                          stream: _audioPlayer.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final processingState =
                                playerState?.processingState;
                            final playing = playerState?.playing;

                            if (processingState == ProcessingState.loading ||
                                processingState == ProcessingState.buffering) {
                              // Show loading indicator while loading or buffering
                              return Container(
                                margin: const EdgeInsets.all(8),
                                width: 64,
                                height: 64,
                                child: const CircularProgressIndicator(),
                              );
                            } else if (processingState ==
                                ProcessingState.completed) {
                              // Show replay button when the audio reaches the end
                              return IconButton(
                                iconSize: 64,
                                onPressed:
                                    seekRestart, // Seek to the start of the track
                                icon: const Icon(Icons.replay_circle_filled),
                              );
                            } else if (playing != true) {
                              // Show play button when the audio is not playing
                              return IconButton(
                                iconSize: 64,
                                onPressed:
                                    togglePlayPause, // Start or resume playback
                                icon: const Icon(Icons.play_circle_filled),
                              );
                            } else {
                              // Show pause button when the audio is playing
                              return IconButton(
                                iconSize: 64,
                                onPressed: togglePlayPause, // Pause playback
                                icon: const Icon(Icons.pause_circle_filled),
                              );
                            }
                          },
                        ),
                        IconButton(
                          onPressed: seekForward,
                          icon: const Icon(Icons.skip_next),
                        ),
                        IconButton(
                          onPressed: toggleLoop,
                          icon: Icon(
                            isLooping ? Icons.repeat_one : Icons.repeat,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
