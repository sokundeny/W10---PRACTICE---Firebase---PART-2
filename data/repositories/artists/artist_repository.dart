import '../../../model/artists/artist.dart';

abstract class ArtistRepository {
  Future<List<Artist>> fetchArtist({bool forceFetch = false});

  Future<Artist?> fetchArtistById(String id);
}
