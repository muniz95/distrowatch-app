import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:redux/redux.dart';
import 'package:distrowatchapp/redux/theater/theater_state.dart';

final theaterReducer = combineReducers<TheaterState>([
  new TypedReducer<TheaterState, InitCompleteAction>(_initComplete),
  new TypedReducer<TheaterState, ChangeCurrentTheaterAction>(
      _currentTheaterChanged),
]);

TheaterState _initComplete(TheaterState state, InitCompleteAction action) {
  return state.copyWith(
    currentTheater: action.selectedTheater,
    theaters: action.theaters,
  );
}

TheaterState _currentTheaterChanged(
    TheaterState state, ChangeCurrentTheaterAction action) {
  return state.copyWith(currentTheater: action.selectedTheater);
}
