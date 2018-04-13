import 'dart:async';

import 'package:distrowatchapp/data/models/distro.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/data/models/main_distro.dart';
import 'package:distrowatchapp/data/models/show.dart';
import 'package:distrowatchapp/data/models/theater.dart';
import 'package:distrowatchapp/utils/http_utils.dart';
import 'package:intl/intl.dart';

class DwApi {
  static final DateFormat ddMMyyyy = new DateFormat('dd.MM.yyyy');
  static final String baseURL = 'www.distrowatch.com';

  static final Uri kScheduleBaseUrl =
      new Uri.https('www.finnkino.com', '/en/xml/Schedule');
  static final Uri kEventsBaseUrl =
      new Uri.https('www.finnkino.com', '/en/xml/Events');
  static final Uri dMainDistros = new Uri.https(baseURL, '/dwres.php');

  Future<List<Show>> getSchedule(Theater theater, DateTime date) async {
    var dt = ddMMyyyy.format(date ?? new DateTime.now());
    var response = await getRequest(
      kScheduleBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'dt': dt,
      }),
    );

    return Show.parseAll(response);
  }

  Future<List<Event>> getNowInTheatersEvents(Theater theater) async {
    var response = await getRequest(
      kEventsBaseUrl.replace(queryParameters: {
        'area': theater.id,
        'listType': 'NowInTheatres',
      }),
    );

    return Event.parseAll(response);
  }

  Future<List<Event>> getUpcomingEvents() async {
    var response = await getRequest(
      kEventsBaseUrl.replace(queryParameters: {
        'listType': 'ComingSoon',
      }),
    );

    return Event.parseAll(response);
  }

  Future<List<Distro>> getDistros() async {
    var response = await getRequest(
      dMainDistros.replace(queryParameters: {
        'resource': 'major',
      }),
    );

    return Distro.parseAll(response);
  }

  Future<List<MainDistro>> getMainDistros() async {
    var response = await getRequest(
      dMainDistros.replace(queryParameters: {
        'resource': 'major',
      }),
    );

    return MainDistro.parseAll(response);
  }
}
