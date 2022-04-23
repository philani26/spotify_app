class ImageIcon {
  late String url;

  ImageIcon.fromJson(Map<String, dynamic> json) {
    url = json["url"];
  }
}
