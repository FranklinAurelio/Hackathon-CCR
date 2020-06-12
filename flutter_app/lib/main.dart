import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/Login.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sentry/sentry.dart';

final String termosPrivacidade = "https://www.lexio.legal/modelo/termos-de-uso";
final String termosdeUso = "https://www.lexio.legal/modelo/termos-de-uso";

//Sentry service connection for bugs reporting
final _sentry = SentryClient(dsn: null);

//Handle errors on Release Mode
void _onError(Object error, StackTrace stackTrace) {
  /*
    Debug mode: display the current error on the console
    Release mode: report on sentry platform
   */
  if (kDebugMode) {
    print('Error Caught: $error');
    print(stackTrace);
  } else {
    _sentry.captureException(exception: error, stackTrace: stackTrace);
  }
}

void main() {
  FlutterError.onError = (details) {
    /*
    Debug mode: Display on console
    Release mode: Report on Sentry Platform
     */
    if (kDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  //This function only works on Dart 2.8.x
  /*runZonedGuarded<Future<void>>(
    () async {
      runApp(MyApp());
    },
    _onError,
  );

   */

  //use this if you are using dart 2.7.x or behavior

  runZoned<Future<void>>(
    () async {
      runApp(MyApp());
    },
    onError: _onError
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        //headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  int index;

  @override
  Widget build(BuildContext context) {
    const String toLaunch =
        'https://www.google.com/maps/@-23.2616034,-45.8944638,15z';
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                "assets/images/fundo.png",
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                //SizedBox(height: 10.0,),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 140,
                  ),
                ),

                SizedBox(
                  height: 12.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red,
                  child: MaterialButton(
                    height: 60.0,
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text("Navegação",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    onPressed: () async {
                      _launched = _launchInBrowser(toLaunch);
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red,
                  child: MaterialButton(
                    height: 60.0,
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text("Saúde",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    onPressed: () async {
                      //
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.red,
                  child: MaterialButton(
                    height: 60.0,
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text("Financeiro",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    onPressed: () async {
                      //
                    },
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Material(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.deepOrange,
                  child: MaterialButton(
                    height: 60.0,
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text("Panico",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    onPressed: () async {
                      //
                    },
                  ),
                ),
                SizedBox(width: 50.0,),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  iconSize: 50.0,
                  alignment: Alignment.bottomLeft,
                  color: Colors.black,
                  onPressed: () async{
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
