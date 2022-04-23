import 'package:flutter_spotify_africa_assessment/features/spotify/model/image_icon.dart';

class CategoryModel {
  late String id, name, href;
  late List<ImageIcon> images = [];

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    href = json["href"];

    List<dynamic> listImages = json["icons"];
    images = listImages.map((e) => ImageIcon.fromJson(e)).toList();
  }

  CategoryModel({required this.href, required this.id});
}
