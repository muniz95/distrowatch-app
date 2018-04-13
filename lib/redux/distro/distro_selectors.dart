import 'package:distrowatchapp/data/models/distro.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';

List<Distro> distrosSelector(AppState state) {
  var distros = state.distroState.distros;

  if (state.searchQuery == null) {
    return distros;
  }

  return _distrosWithSearchQuery(state, distros);
}

List<Distro> _distrosWithSearchQuery(AppState state, List<Distro> distros) {
  var searchQuery = new RegExp(state.searchQuery, caseSensitive: false);

  return distros.where((distro) {
    return distro.name.contains(searchQuery);
  }).toList();
}
