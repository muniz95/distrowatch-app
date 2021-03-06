import 'dart:io';

import 'package:flutter/services.dart';
import 'package:distrowatchapp/data/networking/dw_api.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:mockito/mockito.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockFile extends Mock implements File {}

class MockDwApi extends Mock implements DwApi {}
class MockAssetBundle extends Mock implements AssetBundle {}

class MockStore extends Mock implements Store<AppState> {}
class MockPreferences extends Mock implements SharedPreferences {}