import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/model/category_model.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/service/sportify_service_api.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/widgets/landing_playlist.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';

// Feel free to change this to a stateful widget if necessary
class SpotifyCategory extends StatelessWidget {
  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryId),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.about),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppColors.blue,
                AppColors.cyan,
                AppColors.green,
              ],
            ),
          ),
        ),
      ),
      body: Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
              future: SpotifyServiceAPI.getCategory(categoryId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Something went wrong refresh the App',
                      style: Theme.of(context).textTheme.headline3?.copyWith(
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  );
                }

                CategoryModel data = snapshot.data as CategoryModel;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(data.images.first.url)),
                          )
                        ]),
                      ),
                      LandingPlayList(categoryId: categoryId)
                    ],
                  ),
                );
              })),
    );
  }
}
