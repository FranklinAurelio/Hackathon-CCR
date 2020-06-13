import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/repositories/url_launch.dart';
import 'package:flutterapp/widgets/logo.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/defaults.dart';

class PanicoScreen extends StatelessWidget {

  ShapeBorder get _defaultBorder => const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0))
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Opacity(
            opacity: 0.3,
            child: Image.asset(
              "assets/images/fundo.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
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
                        shape: _defaultBorder,
                        margin: EdgeInsets.zero,
                        color: Defaults.red,
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
                        shape: _defaultBorder,
                        color: Defaults.red,
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
        ],
      ),
    );
  }
}
