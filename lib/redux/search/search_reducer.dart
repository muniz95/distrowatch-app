import 'package:distrowatchapp/redux/search/search_actions.dart';

String searchQueryReducer(String searchQuery, action) {
  if (action is SearchQueryChangedAction) {
    return action.query;
  }

  return searchQuery;
}
