import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutterapp/screens/QuestionaioList.dart';
import 'package:flutterapp/screens/QuestoesList.dart';
import 'package:flutterapp/screens/panico.dart';
import 'package:router_management/router_management.dart';

import '../Models/Questionario.dart';
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

  static const String saude = '/saude';

  static const String questoes = "/questoes";

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

    controller.addRoute(
        saude,
        (context) => QuestionarioList(),
      useNativeTransitions: _nativeTransition);

    controller.addRoute(
     questoes,
     (context) => QuestoesList(),
      useNativeTransitions: _nativeTransition);
  }


}
