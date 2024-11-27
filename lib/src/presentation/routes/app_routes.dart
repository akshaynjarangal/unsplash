import 'package:flutter/material.dart';

class AppRoutes {
  static const String home = '/';
}

final _navKey = GlobalKey<NavigatorState>();

GlobalKey<NavigatorState> get navKey => _navKey;

NavigatorState? get navigator => _navKey.currentState;

final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

GlobalKey<ScaffoldMessengerState> get scaffoldKey => _scaffoldMessengerKey;

ScaffoldMessengerState? get snackkey => _scaffoldMessengerKey.currentState;