import 'dart:async';

import 'package:distrowatchapp/data/models/distro.dart';
import 'package:distrowatchapp/data/networking/dw_api.dart';
import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/distro/distro_actions.dart';
import 'package:redux/redux.dart';

class DistroMiddleware extends MiddlewareClass<AppState> {
  DistroMiddleware(this.api);

  final DwApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is RefreshDistrosAction) {
      await _handleDistrosUpdate(store, action, next);
    }
  }

  Future<Null> _handleDistrosUpdate(
      Store<AppState> store, dynamic action, NextDispatcher next) async {

    next(new RequestingDistrosAction());

    try {
      var distros = await _fetchDistros(next);
      next(new ReceivedDistrosAction(distros));
    } catch(e) {
      next(new ErrorLoadingDistrosAction());
    }
  }

  Future<List<Distro>> _fetchDistros(
    NextDispatcher next,
  ) async {
    var distros = await api.getDistros();

    // Return only show times that haven't started yet.
    var relevantDistros = distros.where((distro) => distro.popularity <= 20).toList();

    return relevantDistros;
  }
}
