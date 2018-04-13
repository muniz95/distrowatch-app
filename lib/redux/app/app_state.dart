import 'package:distrowatchapp/data/models/actor.dart';
import 'package:distrowatchapp/redux/distro/distro_state.dart';
import 'package:distrowatchapp/redux/event/event_state.dart';
import 'package:distrowatchapp/redux/show/show_state.dart';
import 'package:distrowatchapp/redux/theater/theater_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  AppState({
    @required this.searchQuery,
    @required this.actorsByName,
    @required this.theaterState,
    @required this.showState,
    @required this.distroState,
    @required this.eventState,
  });

  final String searchQuery;
  final Map<String, Actor> actorsByName;
  final TheaterState theaterState;
  final ShowState showState;
  final DistroState distroState;
  final EventState eventState;

  factory AppState.initial() {
    return new AppState(
      searchQuery: null,
      actorsByName: <String, Actor>{},
      theaterState: new TheaterState.initial(),
      showState: new ShowState.initial(),
      distroState: new DistroState.initial(),
      eventState: new EventState.initial(),
    );
  }

  AppState copyWith({
    String searchQuery,
    Map<String, Actor> actorsByName,
    TheaterState theaterState,
    ShowState showState,
    DistroState distroState,
    EventState eventState,
  }) {
    return new AppState(
      searchQuery: searchQuery ?? this.searchQuery,
      actorsByName: actorsByName ?? this.actorsByName,
      theaterState: theaterState ?? this.theaterState,
      showState: showState ?? this.showState,
      distroState: distroState ?? this.distroState,
      eventState: eventState ?? this.eventState,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              searchQuery == other.searchQuery &&
              actorsByName == other.actorsByName &&
              theaterState == other.theaterState &&
              showState == other.showState &&
              distroState == other.distroState &&
              eventState == other.eventState;

  @override
  int get hashCode =>
      searchQuery.hashCode ^
      actorsByName.hashCode ^
      theaterState.hashCode ^
      showState.hashCode ^
      distroState.hashCode ^
      eventState.hashCode;
}
