import 'dart:async';
import 'dart:convert';

import 'package:distrowatchapp/data/models/actor.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/utils/http_utils.dart';

/// If this has a red underline, it means that the lib/tmdb_config.dart file
/// is not present on the project. Refer to the README for instructions
/// on how to do so.
import 'package:distrowatchapp/tmdb_config.dart';

class TMDBApi {
  static final String baseUrl = 'api.themoviedb.org';

  Future<List<Actor>> findAvatarsForActors(
      Event event, List<Actor> actors) async {
    int movieId = await _findMovieId(event.originalTitle);

    if (movieId != null) {
      return _getActorAvatars(movieId);
    }

    return actors;
  }

  Future<int> _findMovieId(String movieTitle) async {
    var searchUri = new Uri.https(
      baseUrl,
      '3/search/movie',
      <String, String>{
        'api_key': TMDBConfig.apiKey,
        'query': movieTitle,
      },
    );

    var response = await getRequest(searchUri);
    var movieSearchJson = json.decode(response);
    var searchResults = movieSearchJson['results'];

    if (searchResults.isNotEmpty) {
      return searchResults.first['id'];
    }

    return null;
  }

  Future<List<Actor>> _getActorAvatars(int movieId) async {
    var actorUri = new Uri.https(
      baseUrl,
      '3/movie/$movieId/credits',
      <String, String>{'api_key': TMDBConfig.apiKey},
    );

    var response = await getRequest(actorUri);
    var movieActors = json.decode(response);

    return _parseActorAvatars(
        (movieActors['cast'] as List).cast<Map<String, dynamic>>());
  }

  List<Actor> _parseActorAvatars(List<Map<String, dynamic>> movieCast) {
    var actorsWithAvatars = <Actor>[];

    movieCast.forEach((castMember) {
      var pp = castMember['profile_path'];
      var profilePath =
          pp != null ? 'https://image.tmdb.org/t/p/w200$pp' : null;

      actorsWithAvatars.add(new Actor(
        name: castMember['name'],
        avatarUrl: profilePath,
      ));
    });

    return actorsWithAvatars;
  }
}
