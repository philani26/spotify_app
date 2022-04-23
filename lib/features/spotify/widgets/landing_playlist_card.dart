// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/single_playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/spotify_playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/service/sportify_service_api.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';

class LandingPlayListCard extends StatelessWidget {
  final String categoryId, playListId;
  final SinglePlayListModel? items;
  const LandingPlayListCard(
      {Key? key,
      required this.categoryId,
      required this.playListId,
      this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SpotifyServiceAPI.getSinglePlayList(categoryId, playListId),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        SinglePlayListModel data = snapshot.data as SinglePlayListModel;

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SpotifyPlaylist(
                      categoryId: categoryId,
                      items: data,
                    )));
          },
          child: Container(
            width: (MediaQuery.of(context).size.width - 40) / 2,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              children: [
                Image(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(data.images.first.url)),
                Center(
                  child: Text(data.name),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(data.followers.toString() + " FOLLOWERS"),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
