import 'package:distrowatchapp/redux/actor/actor_reducer.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/event/event_reducer.dart';
import 'package:distrowatchapp/redux/search/search_reducer.dart';
import 'package:distrowatchapp/redux/show/show_reducer.dart';
import 'package:distrowatchapp/redux/distro/distro_reducer.dart';
import 'package:distrowatchapp/redux/main_distro/main_distro_reducer.dart';
import 'package:distrowatchapp/redux/theater/theater_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    searchQuery: searchQueryReducer(state.searchQuery, action),
    actorsByName: actorReducer(state.actorsByName, action),
    theaterState: theaterReducer(state.theaterState, action),
    showState: showReducer(state.showState, action),
    distroState: distroReducer(state.distroState, action),
    mainDistroState: mainDistroReducer(state.mainDistroState, action),
    eventState: eventReducer(state.eventState, action),
  );
}
