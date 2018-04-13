import 'package:distrowatchapp/data/models/distro.dart';
import 'package:distrowatchapp/data/models/theater.dart';

class FetchDistrosAction {
  FetchDistrosAction(this.theater);
  final Theater theater;
}

class RequestingDistrosAction {}

class RefreshDistrosAction {}

class ReceivedDistrosAction {
  ReceivedDistrosAction(this.distros);

  final List<Distro> distros;
}

class ErrorLoadingDistrosAction {}
