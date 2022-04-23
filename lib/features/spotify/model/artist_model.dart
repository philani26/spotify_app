import 'package:flutter_spotify_africa_assessment/features/spotify/model/image_icon.dart';

class ArtisModel {
  ImageIcon image;
  String id, name;

  ArtisModel(this.name, this.id, this.image);

  static ArtisModel fromJson(Map<String, dynamic> json) {
    var i = 0;
    String name = json["name"];
    ImageIcon image = ImageIcon.fromJson(json['images'][i]);
    String id = json["id"];
    return ArtisModel(name, id, image);
  }
}
