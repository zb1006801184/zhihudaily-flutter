import 'package:flutter/material.dart';
import './routes/root.dart';
import 'routes/news_detail.dart';
import 'routes/mine.dart';
import 'routes/mine_message.dart';

final routes = {
  '/root': (context, {arguments}) => Root(),
  '/NewsDetail': (context, {arguments}) => NewsDetail(),
  '/Mine': (context, {arguments}) => Mine(),
  '/MineMessage': (context, {arguments}) => MineMessage(),
};

var onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
