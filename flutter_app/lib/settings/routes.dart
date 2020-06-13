import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:router_management/router_management.dart';

class AppRoutes {
  AppRoutes._internal();

  static final RouterController controller = RouterController();

  static const String panico = 'panico';

  static get _nativeTransition => kIsWeb || Platform.isIOS;

  static void setRoutes() {

  }
}