import 'package:my_app/model/songs/richsong.dart';
import 'package:flutter/material.dart';


class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  final RichSong song;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(song.title),
          subtitle: Row(
            spacing: 20,
            children: [
              Text("${song.duration.inMinutes} mn"),
              Text("${song.artistName}-${song.artistGenre}")
            ],
          ),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
          leading: ClipOval(
            child: Image.network(
              song.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.music_note),
            ),
          ),
        ),
      ),
    );
  }
}
