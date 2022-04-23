import 'package:flutter_spotify_africa_assessment/features/spotify/model/image_icon.dart';

class PlaylistItems {
  final List<ImageIcon> images;
  final String id, name;

  PlaylistItems(this.name, this.id, this.images);

  static PlaylistItems fromJson(Map<String, dynamic> json) {
    String name = json["name"];
    String id = json["id"];
    List<dynamic> listImages = json['images'];
    List<ImageIcon> images =
        listImages.map((e) => ImageIcon.fromJson(e)).toList();
    return PlaylistItems(name, id, images);
  }
}

class PlaylistModel {
  late String href;
  late List<PlaylistItems> items = [];

  PlaylistModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listPlaylistItems = json["items"];
    items = listPlaylistItems.map((e) => PlaylistItems.fromJson(e)).toList();
    href = json["href"];
  }
}
