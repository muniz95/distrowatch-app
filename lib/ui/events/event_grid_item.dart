import 'package:flutter/material.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/ui/events/event_poster.dart';
import 'package:meta/meta.dart';

class EventGridItem extends StatelessWidget {
  EventGridItem({
    @required this.event,
    @required this.onTapped,
  });

  final Event event;
  final VoidCallback onTapped;

  BoxDecoration _buildGradientBackground() {
    return new BoxDecoration(
      gradient: new LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        stops: <double>[0.0, 0.7, 0.7],
        colors: <Color>[
          Colors.black,
          Colors.transparent,
          Colors.transparent,
        ],
      ),
    );
  }

  Widget _buildTextualInfo() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          event.title,
          style: new TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: new Text(
            event.genres,
            style: new TextStyle(
              fontSize: 12.0,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTextStyle(
      style: new TextStyle(color: Colors.white),
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new EventPoster(event: event),
          new Container(
            decoration: _buildGradientBackground(),
            padding: const EdgeInsets.only(
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: _buildTextualInfo(),
          ),
          new Material(
            color: Colors.transparent,
            child: new InkWell(
              onTap: onTapped,
              child: new Container(),
            ),
          ),
        ],
      ),
    );
  }
}
