import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/track_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/widgets/track_search.dart';

class TrackList extends StatefulWidget {
  final List<Track> tracks;
  const TrackList({Key? key, required this.tracks}) : super(key: key);

  @override
  State<TrackList> createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: TrackSearch.searchItem,
        builder: (context, String item, widgets) {
          List<Track> itemView = item.isEmpty
              ? widget.tracks.sublist(0, 3)
              : widget.tracks
                  .where((e) =>
                      e.name.toLowerCase().startsWith(item.toLowerCase()))
                  .toList();

          return Column(
            children: [
              ...itemView.isEmpty
                  ? ([
                      Center(
                        child: Text('A track named $item was not found'),
                      ),
                    ])
                  : itemView.map((e) {
                      String artist =
                          e.artist.map((i) => i.name).toList().join('');

                      return Row(children: [
                        Image(
                            image: NetworkImage(e.coverAlbum.url),
                            height: 60,
                            width: 60),
                        Container(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          height: 70,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.name),
                                const SizedBox(height: 2),
                                Text(
                                  artist,
                                  maxLines: 1,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  e.timeDuration(),
                                  style:
                                      const TextStyle(color: AppColors.green),
                                ),
                              ]),
                        ),
                      ]);
                    }).toList()
            ],
          );
        });
  }
}
