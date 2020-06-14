import 'package:anjodaestrada/settings/routes.dart';
import 'package:flutter/material.dart';
import 'package:anjodaestrada/widgets/button.dart';

class Saude extends StatefulWidget {

  @override
  _SaudeState createState() => _SaudeState();
}

class _SaudeState extends State<Saude> {

  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            //SizedBox(height: 10.0,),
            SizedBox(
              height: 30.0,
            ),
            ButtonWidget(
              onPressed: () async {
                Navigator.pushNamed(context, AppRoutes.saude);
              },
              color: Colors.blueAccent,
              child: Text(
                "Questionário",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            ButtonWidget(
              onPressed: () {
               //
              },
              color: Colors.blueAccent,
              child: Text(
                "Enfermeira Virtual",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            ButtonWidget
              (
              color: Colors.blueAccent,
              onPressed: () async {
                //
              },
              child: Text(
                "Teleconsulta",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            ButtonWidget(
              color: Colors.blueAccent,
              onPressed: () async {
              //
              },
              child: Text("Dados médicos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 12.0,
            ),
            ButtonWidget(
              color: Colors.blueAccent,
              onPressed: () async {
                //
              },
              child: Text("Agendamentos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              width: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}