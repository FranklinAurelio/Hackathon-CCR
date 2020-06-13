import 'dart:convert';

import 'package:meta/meta.dart';

class ReceivedNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  String toJson() {
    return json.encode({
      'id': id,
      'title': title,
      'body': body,
      'payload': payload,
    });
  }
}
