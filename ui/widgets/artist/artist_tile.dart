import 'package:flutter/material.dart';

import '../../../model/artists/artist.dart';

class ArtistTile extends StatelessWidget {
  const ArtistTile({
    super.key,
    required this.artist,
  });

  final Artist artist;

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
          title: Text(artist.name),
          subtitle: Text(artist.genre),
          leading: ClipOval(
            child: Image.network(
              artist.imageUrl,
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
