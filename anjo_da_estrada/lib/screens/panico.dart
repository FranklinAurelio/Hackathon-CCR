import 'package:flutter/material.dart';
import 'package:anjodaestrada/repositories/url_launch.dart';
import 'package:anjodaestrada/widgets/logo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/defaults.dart';
import '../utils/defaults.dart';

class PanicoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:           SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              const LogoWidget(),
              const SizedBox(height: 24.0),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24.0,
                  crossAxisSpacing: 24.0,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.zero,
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: IconButton(
                          iconSize: 80,
                          color: Colors.white,
                          icon: Icon(FontAwesomeIcons.ambulance),
                          onPressed: () => UrlLaunchRepository.launch('tel:192'),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.blueAccent,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: IconButton(
                          iconSize: 80,
                          color: Colors.white,
                          icon: Icon(Icons.security),
                          onPressed: () => UrlLaunchRepository.launch('tel:193'),
                        ),
                      ),
                    ),
                  )

                ],
              )
            ],
          ),
        ),
      )
      ,
    );
  }
}
