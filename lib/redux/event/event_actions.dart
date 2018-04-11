import 'package:flutter/foundation.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/data/models/theater.dart';

class RefreshEventsAction {}

class FetchEventsAction {
  FetchEventsAction(this.theater);
  final Theater theater;
}

class RequestingEventsAction {}

class ReceivedEventsAction {
  ReceivedEventsAction({
    @required this.nowInTheatersEvents,
    @required this.comingSoonEvents,
  });

  final List<Event> nowInTheatersEvents;
  final List<Event> comingSoonEvents;
}

class ErrorLoadingEventsAction {}
