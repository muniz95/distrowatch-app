import 'package:distrowatchapp/data/models/distro.dart';
import 'package:flutter/material.dart';
import 'package:distrowatchapp/ui/common/info_message_view.dart';

class DistrosList extends StatelessWidget {
  static final Key emptyViewKey = new Key('emptyView');
  static final Key contentKey = new Key('content');

  DistrosList(this.distros, this.refreshDistros);
  final List<Distro> distros;
  final Function refreshDistros;

  @override
  Widget build(BuildContext context) {
    if (distros.isEmpty) {
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
        itemCount: distros.length,
        itemBuilder: (BuildContext context, int index) {
          var distro = distros[index];

          return new Column(
            children: <Widget>[
              new Text(distro.name),
              new Divider(
                height: 1.0,
                color: Colors.black.withOpacity(0.25),
              ),
              new MaterialButton(
                onPressed: () => this.refreshDistros(),
              ),
            ],
          );
        },
      ),
    );
  }
}
