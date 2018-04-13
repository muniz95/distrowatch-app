import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/data/models/main_distro.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/main_distro/main_distro_actions.dart';
import 'package:distrowatchapp/redux/main_distro/main_distro_selectors.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class MainDistrosPageViewModel {
  MainDistrosPageViewModel({
    @required this.status,
    @required this.mainDistros,
    @required this.refreshMainDistros,
  });

  final LoadingStatus status;
  final List<MainDistro> mainDistros;
  final Function refreshMainDistros;

  static MainDistrosPageViewModel fromStore(Store<AppState> store) {
    return new MainDistrosPageViewModel(
      status: store.state.mainDistroState.loadingStatus,
      mainDistros: mainDistrosSelector(store.state),
      refreshMainDistros: () => store.dispatch(new RefreshMainDistrosAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MainDistrosPageViewModel &&
              runtimeType == other.runtimeType &&
              status == other.status &&
              mainDistros == other.mainDistros &&
              refreshMainDistros == other.refreshMainDistros;

  @override
  int get hashCode =>
      status.hashCode ^
      mainDistros.hashCode ^
      refreshMainDistros.hashCode;
}
