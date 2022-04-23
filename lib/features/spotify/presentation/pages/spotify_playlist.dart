// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/single_playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/widgets/artist_list.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/widgets/track_list.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/widgets/track_search.dart';

class SpotifyPlaylist extends StatefulWidget {
  final String categoryId;
  final SinglePlayListModel items;

  const SpotifyPlaylist(
      {Key? key, required this.categoryId, required this.items})
      : super(key: key);

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();
}

class _SpotifyPlaylistState extends State<SpotifyPlaylist> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                TrackSearch.searchItem = ValueNotifier("");
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios)),
          TrackSearch(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: size.width,
                        height: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.items.images.first.url.toString()),
                              fit: BoxFit.fill),
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    Text(widget.items.description.toString(),
                        maxLines: 2, style: TextStyle(color: Colors.grey)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(widget.items.followers.toString() + ' ' + 'likes'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.items.duration.toString(),
                          style: TextStyle(color: AppColors.green),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TrackList(tracks: widget.items.tracks),
                    ArtistList(items: widget.items),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
