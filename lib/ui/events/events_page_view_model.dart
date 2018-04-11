import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/event/event_actions.dart';
import 'package:distrowatchapp/redux/event/event_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class EventsPageViewModel {
  EventsPageViewModel({
    @required this.status,
    @required this.events,
    @required this.refreshEvents,
  });

  final LoadingStatus status;
  final List<Event> events;
  final Function refreshEvents;

  static EventsPageViewModel fromStore(
    Store<AppState> store,
    EventListType type,
  ) {
    return new EventsPageViewModel(
      status: store.state.eventState.loadingStatus,
      events: eventsSelector(store.state, type),
      refreshEvents: () => store.dispatch(new RefreshEventsAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is EventsPageViewModel &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              events == other.events &&
              refreshEvents == other.refreshEvents;

  @override
  int get hashCode =>
      status.hashCode ^
      events.hashCode ^
      refreshEvents.hashCode;
}
