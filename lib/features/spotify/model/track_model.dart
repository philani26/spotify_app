import 'package:flutter_spotify_africa_assessment/features/spotify/model/image_icon.dart';

class Artist {
  String id, name;
  Artist(this.name, this.id);
}

class Track {
  ImageIcon coverAlbum;
  int duration;
  String id, name;
  List<Artist> artist;

  Track(this.artist, this.name, this.id, this.duration, this.coverAlbum);

  static Track fromJson(Map<String, dynamic> json) {
    String name = json["name"];
    String id = json["id"];
    int duration = json["duration_ms"];

    ImageIcon coverAlbum = ImageIcon.fromJson(json["album"]["images"][0]);
    List<Artist> artistList = (json["artists"] as List<dynamic>)
        .map((e) => Artist(e["name"], e["id"]))
        .toList();
    return Track(artistList, name, id, duration, coverAlbum);
  }

  String timeDuration() {
    int min, sec;
    min = ((duration / 1000) / 60).floor();
    sec = ((duration / 1000) - (min * 60)).floor();
    return "$min:${sec < 10 ? '0' + sec.toString() : sec}";
  }
}
