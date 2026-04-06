import 'package:my_app/model/songs/song.dart';

class RichSong extends Song{
  final String artistName;
  final String artistGenre;

  RichSong({
    required this.artistName,
    required this.artistGenre, 
    required super.id, 
    required super.title, 
    required super.artist, 
    required super.duration, 
    required super.imageUrl,
    required super.like,
  });

  Song toSong() {
    return Song(
      id: id,
      title: title,
      artist: artist,
      duration: duration,
      imageUrl: imageUrl,
      like: like
    );
  }
}
