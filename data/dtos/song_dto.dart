import '../../model/songs/song.dart';

class SongDto {
  static const String title = 'title';
  static const String artistId = 'artistId';
  static const String duration = 'duration'; // in ms
  static const String imageUrl = 'imageUrl';

  static Song fromJson(String id, Map<String, dynamic> json) {

    return Song(
      id: id,
      title: json[title],
      artist: json[artistId],
      duration: Duration(milliseconds: json[duration]),
      imageUrl:json[imageUrl],
    );
  }

  /// Convert Song to JSON
  Map<String, dynamic> toJson(Song song) {
    return {
      title: song.title,
      artistId: song.artist,
      duration: song.duration.inMilliseconds,
      imageUrl: song.imageUrl,
    };
  }
}
