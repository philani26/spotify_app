import 'dart:convert';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/artist_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/category_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/playlists_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/single_playlist.dart';
import 'package:http/http.dart' as http;

class SpotifyServiceAPI {
  static const apiKey =
      '21WgX6piPoeo2kGavN8pdJUMes0HbjuGO1B5itLl0cPzC40IywU3Xg==';
  static const baseURL =
      'https://palota-jobs-africa-spotify-fa.azurewebsites.net/api/';

  static Future<CategoryModel> getCategory(String categoryId) async {
    final res = await http.get(
        Uri.parse('${baseURL}browse/categories/$categoryId'),
        headers: {'x-functions-key': apiKey});
    return CategoryModel.fromJson(json.decode(res.body));
  }

  static Future<SinglePlayListModel> getSinglePlayList(
      String categoryId, String playlistId) async {
    final res = await http.get(Uri.parse('${baseURL}playlists/$playlistId'),
        headers: {'x-functions-key': apiKey});
    Map<String, dynamic> json = jsonDecode(res.body);
    return SinglePlayListModel.fromJson(json);
  }

  static Future<ArtisModel> getArtistById(String artistId) async {
    final res = await http.get(Uri.parse('${baseURL}artists/$artistId'),
        headers: {'x-functions-key': apiKey});
    Map<String, dynamic> json = jsonDecode(res.body);
    return ArtisModel.fromJson(json);
  }

  static Future<PlaylistModel> getPlayList(String categoryId,
      {limit = 20, offset = 0}) async {
    final res = await http.get(
        Uri.parse(
            '${baseURL}browse/categories/$categoryId/playlists?limit=${limit.toString()}&offset=${offset.toString()}'),
        headers: {'x-functions-key': apiKey});
    Map<String, dynamic> data = jsonDecode(res.body);
    return PlaylistModel.fromJson(data["playlists"]);
  }
}
