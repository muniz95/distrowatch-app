import 'package:distrowatchapp/data/loading_status.dart';
import 'package:distrowatchapp/redux/main_distro/main_distro_actions.dart';
import 'package:distrowatchapp/redux/main_distro/main_distro_state.dart';
import 'package:redux/redux.dart';

final mainDistroReducer = combineReducers<MainDistroState>([
  new TypedReducer<MainDistroState, RequestingMainDistrosAction>(_requestingMainDistros),
  new TypedReducer<MainDistroState, ReceivedMainDistrosAction>(_receivedMainDistros),
  new TypedReducer<MainDistroState, ErrorLoadingMainDistrosAction>(_errorLoadingMainDistros),
]);

MainDistroState _requestingMainDistros(MainDistroState state, RequestingMainDistrosAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.loading);
}

MainDistroState _receivedMainDistros(MainDistroState state, ReceivedMainDistrosAction action) {
  return state.copyWith(
    loadingStatus: LoadingStatus.success,
    mainDistros: action.mainDistros,
  );
}

MainDistroState _errorLoadingMainDistros(MainDistroState state, ErrorLoadingMainDistrosAction action) {
  return state.copyWith(loadingStatus: LoadingStatus.error);
}
