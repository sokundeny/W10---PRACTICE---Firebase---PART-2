import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  final Uri songsUri = Uri.https('the-best-by-the-best-default-rtdb.asia-southeast1.firebasedatabase.app', '/songs.json');
  List<Song>? _cachedSongs;

  @override
  Future<List<Song>> fetchSongs({bool forceFetch = false}) async {

    if (!forceFetch && _cachedSongs != null) {
      return _cachedSongs!;
    }

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      // 1 - Send the retrieved list of songs
      final Map<String, dynamic> songJson = Map<String, dynamic>.from(json.decode(response.body));
      
      final songs =songJson.entries
          .map(
            (entry) => SongDto.fromJson(
              entry.key,
              Map<String, dynamic>.from(entry.value),
            ),
          )
          .toList();  
      _cachedSongs = songs;
      return songs;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<void> likeSong(String songId, int currentLikes) async {
    final newLikes = currentLikes + 1;

    final songUri = Uri.https(
      'the-best-by-the-best-default-rtdb.asia-southeast1.firebasedatabase.app',
      '/songs/$songId.json',
    );

    final response = await http.patch(
      songUri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"like": newLikes}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to like song");
    }
  }

  @override
  Future<Song?> fetchSongById(String id) async {}
}
