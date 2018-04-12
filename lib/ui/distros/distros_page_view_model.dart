import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/data/models/show.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/show/show_actions.dart';
import 'package:distrowatchapp/redux/show/show_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class DistrosPageViewModel {
  DistrosPageViewModel({
    @required this.status,
    @required this.dates,
    @required this.selectedDate,
    @required this.shows,
    @required this.changeCurrentDate,
    @required this.refreshDistros,
  });

  final LoadingStatus status;
  final List<DateTime> dates;
  final DateTime selectedDate;
  final List<Show> shows;
  final Function(DateTime) changeCurrentDate;
  final Function refreshDistros;

  static DistrosPageViewModel fromStore(Store<AppState> store) {
    return new DistrosPageViewModel(
      selectedDate: store.state.showState.selectedDate,
      dates: store.state.showState.dates,
      status: store.state.showState.loadingStatus,
      shows: showsSelector(store.state),
      changeCurrentDate: (newDate) {
        store.dispatch(new ChangeCurrentDateAction(newDate));
      },
      refreshDistros: () => store.dispatch(new RefreshShowsAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DistrosPageViewModel &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              dates == other.dates &&
              selectedDate == other.selectedDate &&
              shows == other.shows &&
              changeCurrentDate == other.changeCurrentDate &&
              refreshDistros == other.refreshDistros;

  @override
  int get hashCode =>
      status.hashCode ^
      dates.hashCode ^
      selectedDate.hashCode ^
      shows.hashCode ^
      changeCurrentDate.hashCode ^
      refreshDistros.hashCode;
}
