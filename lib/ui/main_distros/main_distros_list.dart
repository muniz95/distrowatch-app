import 'package:distrowatchapp/data/models/main_distro.dart';
import 'package:flutter/material.dart';
import 'package:distrowatchapp/ui/common/info_message_view.dart';

class MainDistrosList extends StatelessWidget {
  static final Key emptyViewKey = new Key('emptyView');
  static final Key contentKey = new Key('content');

  MainDistrosList(this.mainDistros);
  final List<MainDistro> mainDistros;

  @override
  Widget build(BuildContext context) {
    if (mainDistros.isEmpty) {
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
        itemCount: mainDistros.length,
        itemBuilder: (BuildContext context, int index) {
          var mainDistro = mainDistros[index];

          return new Column(
            children: <Widget>[
              new Card(
                child: new Text(mainDistro.name),
              ),
              new Card(
                child: new Text(mainDistro.info),
              ),
              new Divider(
                height: 1.0,
                color: Colors.black,
              ),
            ],
          );
        },
      ),
    );
  }
}
