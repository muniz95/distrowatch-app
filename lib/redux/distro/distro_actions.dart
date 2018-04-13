import 'package:distrowatchapp/data/models/distro.dart';

class FetchDistrosAction {
  FetchDistrosAction(this.distro);
  final Distro distro;
}

class RequestingDistrosAction {}

class RefreshDistrosAction {}

class ReceivedDistrosAction {
  ReceivedDistrosAction(this.distros);

  final List<Distro> distros;
}

class ErrorLoadingDistrosAction {}
