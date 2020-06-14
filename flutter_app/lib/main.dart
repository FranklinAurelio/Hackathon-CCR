import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/screens/Financeiro.dart';
import 'package:flutterapp/screens/Login.dart';
import 'package:flutterapp/settings/routes.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sentry/sentry.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Functions/LoginFunction.dart';

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

  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: _onError);
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AppRoutes.setRoutes();
    Future<void>.microtask(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anjo da estrada',
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.controller.onGenerateRoute,
    );
  }
}

class HomePage extends StatefulWidget {

  final LatLng destinyAddress;
  HomePage({this.destinyAddress});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Location startPoint;
  Location endPoint;

  MapboxNavigation _directions;
  bool _arrived = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    initialLocation();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initialLocation() async {
    print("Carregando Localizacao");
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    startPoint = Location(name: "Me", latitude: position.latitude, longitude: position.longitude);
    print("${position.latitude}, ${position.longitude}");
    setState(() { });
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    _directions = MapboxNavigation(
        onRouteProgress: (arrived) async {
          setState(() {
            _arrived = arrived;
          });

          if (arrived) {
            await Future.delayed(Duration(seconds: 3));
            await _directions.finishNavigation();
          }
        }
    );
  }



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
                      try {
                        print("Carregando navigation");

                        endPoint = Location(name: 'Destino', latitude: this.widget.destinyAddress.latitude, longitude: this.widget.destinyAddress.longitude);

                        await _directions.startNavigation(
                            origin: startPoint,
                            destination: endPoint,
                            mode: NavigationMode.drivingWithTraffic,
                            simulateRoute: false,
                            units: VoiceUnits.metric,
                            language: "Portuguese"
                        );
                      } catch (e) {
                        toast("Erro no mapa");
                        print("Erro no navigation");
                        print(e.toString());
                      }
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Finances()));
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
                      Navigator.pushNamed(context, AppRoutes.panico);
                    },
                  ),
                ),
                SizedBox(
                  width: 50.0,
                ),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  iconSize: 50.0,
                  alignment: Alignment.bottomLeft,
                  color: Colors.black,
                  onPressed: () async {
                    await logout();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  void toast(String msg) {
    showToastWidget(
        Material(
          child: Container(
            height: 60.0,
            margin: EdgeInsets.symmetric(horizontal: 50.0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 17.0),
            decoration: ShapeDecoration(
              color: Colors.black.withOpacity(0.9),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$msg",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontFamily: "Roboto"
                  ),
                )
              ],
            ),
          ),
        ),
        context: context,
        position: StyledToastPosition.center,
        animation: StyledToastAnimation.scale,
        reverseAnimation: StyledToastAnimation.fade,
        duration: Duration(seconds: 4),
        animDuration: Duration(seconds: 1),
        curve: Curves.elasticOut,
        reverseCurve: Curves.linear
    );
  }
}
