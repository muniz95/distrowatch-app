import 'package:distrowatchapp/data/models/actor.dart';
import 'package:distrowatchapp/data/models/event.dart';

class FetchActorAvatarsAction {
  FetchActorAvatarsAction(this.event);
  final Event event;
}

class ActorsUpdatedAction {
  ActorsUpdatedAction(this.actors);
  final List<Actor> actors;
}

class ReceivedActorAvatarsAction {
  ReceivedActorAvatarsAction(this.actors);
  final List<Actor> actors;
}
