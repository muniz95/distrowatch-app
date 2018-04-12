import 'package:flutter/material.dart';
import 'package:distrowatchapp/data/models/show.dart';
import 'package:distrowatchapp/ui/common/info_message_view.dart';

class DistrosList extends StatelessWidget {
  static final Key emptyViewKey = new Key('emptyView');
  static final Key contentKey = new Key('content');

  DistrosList(this.shows);
  final List<Show> shows;

  @override
  Widget build(BuildContext context) {
    if (shows.isEmpty) {
      return new InfoMessageView(
        key: emptyViewKey,
        title: 'All empty!',
        description:
            'Didn\'t find any movies\nabout to start for today. ¯\\_(ツ)_/¯',
      );
    }

    return new Scrollbar(
      key: contentKey,
      child: new ListView.builder(
        padding: const EdgeInsets.only(bottom: 8.0),
        itemCount: shows.length,
        itemBuilder: (BuildContext context, int index) {
          var show = shows[index];
          var useAlternateBackground = index % 2 == 0;

          return new Column(
            children: <Widget>[
              new Text('Teste'),
              new Divider(
                height: 1.0,
                color: Colors.black.withOpacity(0.25),
              ),
            ],
          );
        },
      ),
    );
  }
}
