class Song {
  final String id;
  final String title;
  final String artist;
  final Duration duration;
  final String imageUrl;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.duration,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Song(id: $id, title: $title, artist: $artist, duration: $duration, imageUrl: $imageUrl)';
  }
}
