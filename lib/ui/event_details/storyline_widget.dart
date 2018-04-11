import 'package:flutter/material.dart';
import 'package:distrowatchapp/data/models/event.dart';

class StorylineWidget extends StatefulWidget {
  StorylineWidget(this.event);
  final Event event;

  @override
  _StorylineWidgetState createState() => new _StorylineWidgetState();
}

class _StorylineWidgetState extends State<StorylineWidget> {
  bool _isExpandable;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpandable = widget.event.shortSynopsis != widget.event.synopsis;
  }

  void _toggleExpandedState() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  Widget _buildCaption() {
    var content = <Widget>[
      new Text(
        'Storyline',
        style: new TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    ];

    if (_isExpandable) {
      var action = _isExpanded ? 'collapse' : 'expand';

      content.add(new Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: new Text(
          '[touch to $action]',
          style: new TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ));
    }

    return new Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: content,
    );
  }

  Widget _buildContent() {
    return new Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new AnimatedCrossFade(
        firstChild: new Text(widget.event.shortSynopsis),
        secondChild: new Text(widget.event.synopsis),
        crossFadeState:
            _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: _isExpandable ? _toggleExpandedState : null,
      child: new Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildCaption(),
            _buildContent(),
          ],
        ),
      ),
    );
  }
}
