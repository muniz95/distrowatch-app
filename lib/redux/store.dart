import 'dart:async';

import 'package:distrowatchapp/redux/distro/distro_middleware.dart';
import 'package:flutter/services.dart';
import 'package:distrowatchapp/data/networking/dw_api.dart';
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
  var dwApi = new DwApi();
  var prefs = await SharedPreferences.getInstance();

  return new Store(
    appReducer,
    initialState: new AppState.initial(),
    distinct: true,
    middleware: [
      new ActorMiddleware(tmdbApi),
      new TheaterMiddleware(rootBundle, prefs),
      new ShowMiddleware(dwApi),
      new DistroMiddleware(dwApi),
      new EventMiddleware(dwApi),
    ],
  );
}
