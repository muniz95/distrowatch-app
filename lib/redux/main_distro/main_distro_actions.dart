import 'package:distrowatchapp/data/models/main_distro.dart';

class FetchMainDistrosAction {
  FetchMainDistrosAction(this.mainDistro);
  final MainDistro mainDistro;
}

class RequestingMainDistrosAction {}

class RefreshMainDistrosAction {}

class ReceivedMainDistrosAction {
  ReceivedMainDistrosAction(this.mainDistros);

  final List<MainDistro> mainDistros;
}

class ErrorLoadingMainDistrosAction {}
