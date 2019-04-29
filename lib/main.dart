import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:distrowatchapp/redux/store.dart';
import 'package:distrowatchapp/ui/main_page.dart';
import 'package:redux/redux.dart';

Future<Null> main() async {
  // // ignore: deprecated_member_use
  // MaterialPageRoute.debugEnableFadingRoutes = true;

  var store = await createStore();
  runApp(new DistrowatchApp(store));
}

class DistrowatchApp extends StatefulWidget {
  DistrowatchApp(this.store);
  final Store<AppState> store;

  @override
  _DistrowatchAppState createState() => new _DistrowatchAppState();
}

class _DistrowatchAppState extends State<DistrowatchApp> {
  @override
  void initState() {
    super.initState();
    widget.store.dispatch(new InitAction());
  }

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: widget.store,
      child: new MaterialApp(
        title: 'Distrowatch',
        theme: new ThemeData(
          primaryColor: new Color(0xFFF6EDC8),
          accentColor: new Color(0xFFFFAD32),
        ),
        home: new MainPage(),
      ),
    );
  }
}
