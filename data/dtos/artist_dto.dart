import '../../model/artists/artist.dart';

class ArtistDto {
  static const String name = 'name';
  static const String genre = 'genre';
  static const String imageUrl = 'imageUrl';

  static Artist fromJson(String id, Map<String, dynamic> json) {

    return Artist(
      id: id,
      name: json[name],
      genre: json[genre],
      imageUrl: json[imageUrl],
    );
  }

  /// Convert artist to JSON
  Map<String, dynamic> toJson(Artist artist) {
    return {
      name: artist.name,
      genre: artist.genre,
      imageUrl: artist.imageUrl,
    };
  }
}
