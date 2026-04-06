import 'package:my_app/model/songs/richsong.dart';
import 'package:flutter/material.dart';


class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
    required this.onLike
  });

  final RichSong song;
  final bool isPlaying;
  final VoidCallback onTap;
  final VoidCallback onLike;

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
              Text("${song.artistName}-${song.artistGenre}"),
              Text("${song.like} Likes"),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isPlaying ? "Playing" : "",
                style: TextStyle(color: Colors.amber),
              ),
              IconButton(
                onPressed: onLike, 
                icon: Icon(
                  Icons.favorite,
                ),
              )
            ],
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
