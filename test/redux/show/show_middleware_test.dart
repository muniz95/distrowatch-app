import 'dart:async';

import 'package:distrowatchapp/data/models/show.dart';
import 'package:distrowatchapp/data/models/theater.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/common_actions.dart';
import 'package:distrowatchapp/redux/show/show_actions.dart';
import 'package:distrowatchapp/redux/show/show_middleware.dart';
import 'package:distrowatchapp/redux/theater/theater_state.dart';
import 'package:distrowatchapp/utils/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../mocks.dart';

void main() {
  group('ShowMiddleware', () {
    final DateTime startOf2018 = new DateTime(2018);
    final Theater theater = new Theater(id: 'abc123', name: 'Test Theater');
    final List<dynamic> actionLog = <dynamic>[];
    final Function(dynamic) next = (action) => actionLog.add(action);

    MockDwApi mockDwApi;
    MockStore mockStore;
    ShowMiddleware middleware;

    AppState _theaterState({Theater currentTheater}) {
      return new AppState.initial().copyWith(
        theaterState: new TheaterState.initial().copyWith(
          currentTheater: currentTheater,
        ),
      );
    }

    setUp(() {
      mockDwApi = new MockDwApi();
      mockStore = new MockStore();
      middleware = new ShowMiddleware(mockDwApi);

      // Given
      when(mockStore.state).thenReturn(_theaterState(currentTheater: theater));
    });

    tearDown(() {
      actionLog.clear();
      Clock.resetDateTimeGetter();
    });

    test(
      'when called with InitCompleteAction, should dispatch a ReceivedShowsAction with all shows',
      () async {
        // The middleware filters shows based on if the showtime has already
        // passed. As new DateTime(2018) will mean the very first hour and minute
        // in January, all the show times in test assets will be after this date.
        Clock.getCurrentTime = () => startOf2018;
        when(mockDwApi.getSchedule(theater, typed(any)))
            .thenAnswer((_) => new Future.value(<Show>[
          new Show(start: new DateTime(2018, 02, 21)),
          new Show(start: new DateTime(2018, 02, 21)),
          new Show(start: new DateTime(2018, 03, 21)),
        ]));

        // When
        await middleware.call(
            mockStore, new InitCompleteAction(null, theater), next);

        // Then
        verify(mockDwApi.getSchedule(theater, null));

        expect(actionLog.length, 3);
        expect(actionLog[0], new isInstanceOf<InitCompleteAction>());
        expect(actionLog[1], new isInstanceOf<RequestingShowsAction>());

        final ReceivedShowsAction receivedShowsAction = actionLog[2];
        expect(receivedShowsAction.shows.length, 3);
      },
    );

    test(
      'when called with ChangeCurrentDateAction, should dispatch a ReceivedShowsAction with only relevant shows',
      () async {
        // Given
        Clock.getCurrentTime = () => new DateTime(2018, 3);
        when(mockDwApi.getSchedule(theater, typed(any)))
            .thenAnswer((_) => new Future.value(<Show>[
                  new Show(start: new DateTime(2018, 02, 21)),
                  new Show(start: new DateTime(2018, 02, 21)),
                  new Show(start: new DateTime(2018, 03, 21)),
                ]));

        // When
        await middleware.call(
            mockStore, new ChangeCurrentDateAction(startOf2018), next);

        // Then
        verify(mockDwApi.getSchedule(theater, startOf2018));

        expect(actionLog.length, 3);
        expect(actionLog[0], new isInstanceOf<ChangeCurrentDateAction>());
        expect(actionLog[1], new isInstanceOf<RequestingShowsAction>());

        final ReceivedShowsAction receivedShowsAction = actionLog[2];
        expect(receivedShowsAction.shows.length, 1);
      },
    );

    test(
      'when InitCompleteAction results in an error, should dispatch an ErrorLoadingShowsAction',
      () async {
        // Given
        when(mockDwApi.getSchedule(typed(any), typed(any)))
            .thenAnswer((_) => new Future.value(new Error()));

        // When
        await middleware.call(
            mockStore, new InitCompleteAction(null, theater), next);

        // Then
        expect(actionLog.length, 3);
        expect(actionLog[0], new isInstanceOf<InitCompleteAction>());
        expect(actionLog[1], new isInstanceOf<RequestingShowsAction>());
        expect(actionLog[2], new isInstanceOf<ErrorLoadingShowsAction>());
      },
    );
  });
}
