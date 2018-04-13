import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/redux/distro/distro_actions.dart';
import 'package:distrowatchapp/redux/distro/distro_state.dart';
import 'package:redux/redux.dart';

final distroReducer = combineReducers<DistroState>([
  new TypedReducer<DistroState, RequestingDistrosAction>(_requestingDistros),
  new TypedReducer<DistroState, ReceivedDistrosAction>(_receivedDistros),
  new TypedReducer<DistroState, ErrorLoadingDistrosAction>(_errorLoadingDistros),
]);

DistroState _requestingDistros(DistroState state, RequestingDistrosAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

DistroState _receivedDistros(DistroState state, ReceivedDistrosAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    distros: action.distros,
  );
}

DistroState _errorLoadingDistros(DistroState state, ErrorLoadingDistrosAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}
