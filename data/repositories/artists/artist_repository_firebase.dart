import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/artists/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  final Uri artistsUri = Uri.https('the-best-by-the-best-default-rtdb.asia-southeast1.firebasedatabase.app', '/artists.json');
  List<Artist>? _cachedArtists;

  @override
  Future<List<Artist>> fetchArtist({bool forceFetch = false}) async {

    if (!forceFetch && _cachedArtists != null) {
      return _cachedArtists!;
    }
    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      final Map<String, dynamic> artistJson = Map<String, dynamic>.from(json.decode(response.body));
      final artists= artistJson.entries
          .map(
            (entry) => ArtistDto.fromJson(
              entry.key,
              Map<String, dynamic>.from(entry.value),
            ),
          )
          .toList();

      _cachedArtists=artists;
      return artists;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<Artist?> fetchArtistById(String id) {
    // TODO: implement fetchArtistById
    throw UnimplementedError();
  }
}
