import 'dart:async';

import 'package:distrowatchapp/data/models/theater.dart';
import 'package:distrowatchapp/data/networking/dw_api.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:distrowatchapp/redux/event/event_actions.dart';
import 'package:redux/redux.dart';

class EventMiddleware extends MiddlewareClass<AppState> {
  EventMiddleware(this.api);
  final DwApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is ChangeCurrentTheaterAction ||
        action is RefreshEventsAction) {
      var theater = _determineTheater(action, store);

      if (theater != null) {
        await _fetchEvents(theater, next);
      }
    }
  }

  Theater _determineTheater(dynamic action, Store<AppState> store) {
    if (action is RefreshEventsAction) {
      return store.state.theaterState.currentTheater;
    }

    return action.selectedTheater;
  }

  Future<Null> _fetchEvents(
    Theater newTheater,
    NextDispatcher next,
  ) async {
    next(new RequestingEventsAction());

    try {
      var inTheatersEvents = await api.getNowInTheatersEvents(newTheater);
      var comingSoonEvents = await api.getUpcomingEvents();

      next(new ReceivedEventsAction(
        nowInTheatersEvents: inTheatersEvents,
        comingSoonEvents: comingSoonEvents,
      ));
    } catch (e) {
      next(new ErrorLoadingEventsAction());
    }
  }
}
