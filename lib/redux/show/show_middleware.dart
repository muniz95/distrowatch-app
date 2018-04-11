import 'dart:async';

import 'package:distrowatchapp/data/models/show.dart';
import 'package:distrowatchapp/data/models/theater.dart';
import 'package:distrowatchapp/data/networking/finnkino_api.dart';
import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/show/show_actions.dart';
import 'package:distrowatchapp/utils/clock.dart';
import 'package:redux/redux.dart';

class ShowMiddleware extends MiddlewareClass<AppState> {
  ShowMiddleware(this.api);

  final FinnkinoApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction ||
        action is RefreshShowsAction ||
        action is ChangeCurrentDateAction) {
      await _handleShowsUpdate(store, action, next);
    }
  }

  Future<Null> _handleShowsUpdate(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    Theater theater = store.state.theaterState.currentTheater;
    DateTime date;

    if (action is InitCompleteAction || action is ChangeCurrentTheaterAction) {
      theater = action.selectedTheater;
    } else if (action is ChangeCurrentDateAction) {
      date = action.date;
    }

    next(new RequestingShowsAction());

    try {
      var shows = await _fetchShows(theater, date, next);
      next(new ReceivedShowsAction(theater, shows));
    } catch(e) {
      next(new ErrorLoadingShowsAction());
    }
  }

  Future<List<Show>> _fetchShows(
    Theater newTheater,
    DateTime currentDate,
    NextDispatcher next,
  ) async {
    var shows = await api.getSchedule(newTheater, currentDate);
    var now = Clock.getCurrentTime();

    // Return only show times that haven't started yet.
    var relevantShows = shows.where((show) {
      return show.start.isAfter(now);
    }).toList();

    return relevantShows;
  }
}
