// ignore_for_file: unnecessary_null_comparison

import 'package:flutter_spotify_africa_assessment/features/spotify/model/image_icon.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/track_model.dart';

class SinglePlayListModel {
  final int followers, duration;
  final List<ImageIcon> images;
  final String name, id, description;
  final List<Track> tracks;

  SinglePlayListModel(this.name, this.id, this.images, this.description,
      this.tracks, this.followers, this.duration);

  static SinglePlayListModel fromJson(Map<String, dynamic> json) {
    String name = json["name"];
    String id = json["id"];
    String description = json["description"];
    int duration = json["duration_ms"] ?? 0;

    int followers = json["followers"] != null ? json["followers"]["total"] : 0;
    List<dynamic> listImages = json['images'];
    List<ImageIcon> images =
        listImages.map((e) => ImageIcon.fromJson(e)).toList();

    List<dynamic> listTracks = json["tracks"]["items"];

    List<Track> tracks = [];
    for (Map<String, dynamic> e in listTracks) {
      if (e != null && e["track"] != null) {
        tracks.add(Track.fromJson(e["track"]));
      }
    }

    return SinglePlayListModel(
        name, id, images, description, tracks, followers, duration);
  }
}
