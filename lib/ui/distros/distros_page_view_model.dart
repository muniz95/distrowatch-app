import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/data/models/distro.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/distro/distro_actions.dart';
import 'package:distrowatchapp/redux/distro/distro_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class DistrosPageViewModel {
  DistrosPageViewModel({
    @required this.status,
    @required this.distros,
    @required this.refreshDistros,
  });

  final LoadingStatus status;
  final List<Distro> distros;
  final Function refreshDistros;

  static DistrosPageViewModel fromStore(Store<AppState> store) {
    return new DistrosPageViewModel(
      status: store.state.distroState.loadingStatus,
      distros: distrosSelector(store.state),
      refreshDistros: () => store.dispatch(new RefreshDistrosAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is DistrosPageViewModel &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              distros == other.distros &&
              refreshDistros == other.refreshDistros;

  @override
  int get hashCode =>
      status.hashCode ^
      distros.hashCode ^
      refreshDistros.hashCode;
}
