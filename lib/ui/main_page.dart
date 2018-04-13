import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:distrowatchapp/data/models/event.dart';
import 'package:distrowatchapp/data/models/theater.dart';
import 'package:distrowatchapp/redux/app/app_state.dart';
import 'package:distrowatchapp/redux/search/search_actions.dart';
import 'package:distrowatchapp/ui/events/events_page.dart';
import 'package:distrowatchapp/ui/showtimes/showtimes_page.dart';
import 'package:distrowatchapp/ui/theater_list/distrowatch_drawer_header.dart';
import 'package:distrowatchapp/ui/theater_list/theater_list.dart';

import 'distros/distros_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TabController _controller;
  TextEditingController _searchQuery;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    ModalRoute
        .of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      _updateSearchQuery(null);
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    var subtitle = new StoreConnector<AppState, Theater>(
      converter: (store) => store.state.theaterState.currentTheater,
      builder: (BuildContext context, Theater currentTheater) {
        return new Text(
          currentTheater?.name ?? '',
          style: new TextStyle(
            fontSize: 12.0,
            color: Colors.white70,
          ),
        );
      },
    );

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Text('Distrowatch'),
            subtitle,
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search movies & showtimes...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: new TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: _updateSearchQuery,
    );
  }

  void _updateSearchQuery(String newQuery) {
    var store = StoreProvider.of<AppState>(context);
    store.dispatch(new SearchQueryChangedAction(newQuery));
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: new Icon(Icons.clear),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              // Stop searching.
              Navigator.pop(context);
              return;
            }

            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: new Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        leading: _isSearching ? new BackButton() : null,
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
        bottom: new TabBar(
          controller: _controller,
          isScrollable: true,
          tabs: <Tab>[
            new Tab(text: 'Now in theaters'),
            new Tab(text: 'Showtimes'),
            new Tab(text: 'Major distros'),
          ],
        ),
      ),
      drawer: new Drawer(
        child: new TheaterList(
          header: new DistrowatchDrawerHeader(),
          onTheaterTapped: () => Navigator.pop(context),
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          new EventsPage(EventListType.nowInTheaters),
          new ShowtimesPage(),
          new DistrosPage(),
        ],
      ),
    );
  }
}
