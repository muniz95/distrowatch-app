import 'dart:async';

import 'package:flutter/services.dart';
import 'package:distrowatchapp/data/networking/finnkino_api.dart';
import 'package:distrowatchapp/data/networking/tmdb_api.dart';
import 'package:distrowatchapp/redux/actor/actor_middleware.dart';
import 'package:distrowatchapp/redux/app/app_reducer.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/event/event_middleware.dart';
import 'package:distrowatchapp/redux/show/show_middleware.dart';
import 'package:distrowatchapp/redux/theater/theater_middleware.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Store<AppState>> createStore() async {
  var tmdbApi = new TMDBApi();
  var finnkinoApi = new FinnkinoApi();
  var prefs = await SharedPreferences.getInstance();

  return new Store(
    appReducer,
    initialState: new AppState.initial(),
    distinct: true,
    middleware: [
      new ActorMiddleware(tmdbApi),
      new TheaterMiddleware(rootBundle, prefs),
      new ShowMiddleware(finnkinoApi),
      new EventMiddleware(finnkinoApi),
    ],
  );
}
