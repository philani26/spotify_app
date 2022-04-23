// ignore_for_file: prefer_const_constructors

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/artist_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/single_playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/track_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/service/sportify_service_api.dart';

class ArtistList extends StatefulWidget {
  final SinglePlayListModel items;
  const ArtistList({Key? key, required this.items}) : super(key: key);

  @override
  State<ArtistList> createState() => _ArtistListState();
}

class _ArtistListState extends State<ArtistList> {
  Map<String, dynamic> listArtists = <String, int>{};

  @override
  Widget build(BuildContext context) {
    widget.items.tracks
        .map((e) => {
              for (Artist trackArt in e.artist)
                {
                  if (!listArtists.containsKey(trackArt.id))
                    listArtists[trackArt.id] = 1,
                  listArtists[trackArt.id] = listArtists[trackArt.id]! + 1
                }
            })
        .toList();

    final sortedArtist = SplayTreeMap<String, dynamic>.from(listArtists,
        (first, last) => listArtists[first]! > listArtists[last]! ? -1 : 1);

    return Column(
      children: [
        Text("Artists in this playlist",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.normal,
                )),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: [
              ...sortedArtist.keys
                  .map((id) => FutureBuilder(
                      future: SpotifyServiceAPI.getArtistById(id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }

                        ArtisModel data = snapshot.data as ArtisModel;
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 80,
                              width: 80,
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(data.image.url),
                              ),
                            ),
                          ),
                          Text(data.name),
                        ]);
                      }))
                  .toList(),
            ]),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
