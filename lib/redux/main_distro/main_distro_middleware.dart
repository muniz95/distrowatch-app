import 'dart:async';

import 'package:distrowatchapp/data/models/main_distro.dart';
import 'package:distrowatchapp/data/networking/dw_api.dart';
import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/main_distro/main_distro_actions.dart';
import 'package:redux/redux.dart';

class MainDistroMiddleware extends MiddlewareClass<AppState> {
  MainDistroMiddleware(this.api);

  final DwApi api;

  @override
  Future<Null> call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);

    if (action is InitCompleteAction ||
        action is RefreshMainDistrosAction) {
      await _handleMainDistrosUpdate(store, action, next);
    }
  }

  Future<Null> _handleMainDistrosUpdate(
      Store<AppState> store, dynamic action, NextDispatcher next) async {

    next(new RequestingMainDistrosAction());

    try {
      var distros = await _fetchMainDistros(next);
      next(new ReceivedMainDistrosAction(distros));
    } catch(e) {
      next(new ErrorLoadingMainDistrosAction());
    }
  }

  Future<List<MainDistro>> _fetchMainDistros(
    NextDispatcher next,
  ) async {
    var mainDistros = await api.getMainDistros();

    return mainDistros;
  }
}
