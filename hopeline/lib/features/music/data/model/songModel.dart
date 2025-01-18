import 'package:hopeline/features/music/domain/entities/song.dart';

class SongModel extends Song {
  SongModel({
    required int id,
    required String title,
    required String artist,
    required String songLink,
  }) : super(id: id, title: title, artist: artist, songLink: songLink);

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      songLink: json['songLink'],
    );
  }
}
