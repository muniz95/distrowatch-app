import 'package:distrowatchapp/data/models/main_distro.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';

List<MainDistro> mainDistrosSelector(AppState state) {
  var mainDistros = state.mainDistroState.mainDistros;

  if (state.searchQuery == null) {
    return mainDistros;
  }

  return _mainDistrosWithSearchQuery(state, mainDistros);
}

List<MainDistro> _mainDistrosWithSearchQuery(AppState state, List<MainDistro> mainDistros) {
  var searchQuery = new RegExp(state.searchQuery, caseSensitive: false);

  return mainDistros.where((mainDistro) {
    return mainDistro.name.contains(searchQuery);
  }).toList();
}
