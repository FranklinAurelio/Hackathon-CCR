import 'package:flutter/material.dart';

class QuestoesBloc {
  final listenable = ValueNotifier<String>(null);

  set answer(String answer) {
    listenable.value = answer;
  }

  String get answer => listenable.value;
}