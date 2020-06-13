import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class UrlLaunchRepository {
  UrlLaunchRepository._();

  static Future<bool> launch(String url) async {
   try {
     if (await url_launcher.canLaunch(url)) {
       return await url_launcher.launch(url,);
     } else {
       print('cannot launch');
       return false;
     }
   } catch(e,str) {
     if(kDebugMode) {
       print('Error caught: $e');
       print(str);
     }
     return false;
   }
  }
}
