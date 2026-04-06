import 'package:my_app/data/repositories/artists/artist_repository.dart';
import 'package:my_app/model/songs/richsong.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepo;
  final PlayerState playerState;

  AsyncValue<List<RichSong>> songsValue = AsyncValue.loading();

  LibraryViewModel({required this.songRepository,required this.artistRepo, required this.playerState}) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch is successfull
      final songs = await songRepository.fetchSongs();
      final artists = await artistRepo.fetchArtist();

      // 2- Join using nested loop
      final richSongs = <RichSong>[];
      for (var song in songs) {
        for (var artist in artists) {
          if (artist.id == song.artist) {
            richSongs.add(
              RichSong(
                id: song.id,
                title: song.title,
                artist: song.artist,
                artistName: artist.name,
                artistGenre: artist.genre,
                duration: song.duration,
                imageUrl: song.imageUrl,
                like: song.like
              ),
            );
            break;
          }
        }
      }

      songsValue = AsyncValue.success(richSongs);
    } catch (e) {
      // 3- Fetch is unsucessfull
      songsValue = AsyncValue.error(e);
    }
     notifyListeners();

  }

  Future<void> likeSong(RichSong song) async {
  try {
    await songRepository.likeSong(song.id, song.like);

    if (songsValue.state == AsyncValueState.success) {
      final updatedSongs = songsValue.data!.map((s) {
        if (s.id == song.id) {
          s.like+=1;
          return s; 
        }
        return s;
      }).toList();

      songsValue = AsyncValue.success(updatedSongs);
      notifyListeners();
    }
  } catch (e) {
    print("Failed to like song: $e");
  }
}

  bool isSongPlaying(Song song) => playerState.currentSong?.id == song.id;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
