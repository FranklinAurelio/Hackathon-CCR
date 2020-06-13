import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutterapp/screens/panico.dart';
import 'package:router_management/router_management.dart';

import '../main.dart';
import '../screens/Login.dart';
import '../screens/Login.dart';

class AppRoutes {
  AppRoutes._internal();

  static final RouterController controller = RouterController();

  static const String home = '/home';

  static const String login = '/login';

  static const String register = '/register';

  static const String panico = '/panico';

  static get _nativeTransition => kIsWeb || Platform.isIOS;

  static void setRoutes() {
    controller.addRoute(
      home,
      (context) => HomePage(),
      useNativeTransitions: _nativeTransition,
    );
    controller.addRoute(
      login,
      (context) => Login(),
      useNativeTransitions: _nativeTransition,
    );
    controller.addRoute(
      register,
      (context) => Register(),
      useNativeTransitions: _nativeTransition,
    );

    controller.addRoute(
      panico,
      (context) => PanicoScreen(),
      useNativeTransitions: _nativeTransition,
    );
  }
}
