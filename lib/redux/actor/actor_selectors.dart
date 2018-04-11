import 'package:distrowatchapp/data/models/actor.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';

List<Actor> actorsForEventSelector(AppState state, Event event) {
  return state.actorsByName.values
      .where((actor) => event.actors.contains(actor))
      .toList();
}
