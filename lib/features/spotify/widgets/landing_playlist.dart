// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/playlists_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/service/sportify_service_api.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/widgets/landing_playlist_card.dart';

class LandingPlayList extends StatefulWidget {
  final String categoryId;
  const LandingPlayList({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<LandingPlayList> createState() => _LandingPlayListState();
}

class _LandingPlayListState extends State<LandingPlayList> {
  int limit = 4, offset = 0;

  @override
  Widget build(BuildContext context) {
    Future<PlaylistModel> listGrid = SpotifyServiceAPI.getPlayList(
        widget.categoryId,
        limit: limit,
        offset: offset * limit);
    return FutureBuilder(
        future: listGrid,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          PlaylistModel data = snapshot.data as PlaylistModel;
          return Column(
            children: [
              Row(children: [
                IconButton(
                    onPressed: () => setState(
                        () => offset > 0 ? offset -= 1 : offset == offset),
                    icon: Icon(Icons.arrow_back_ios)),
                Text((offset + 1).toString()),
                IconButton(
                    onPressed: () => setState(() => offset += 1),
                    icon: Icon(Icons.arrow_forward_ios)),
              ]),
              Wrap(
                children: data.items
                    .map((e) => LandingPlayListCard(
                        categoryId: widget.categoryId, playListId: e.id))
                    .toList(),
              ),
            ],
          );
        });
  }
}
