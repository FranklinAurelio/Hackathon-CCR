import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:loading/indicator/ball_spin_fade_loader_indicator.dart';
import 'package:loading/loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:anjodaestrada/utils/defaults.dart';

class PdfView extends StatefulWidget {
  String url;
  String title;
  PdfView({this.url, this.title});

  @override
  _PdfViewState createState() => new _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  String pathPDF = "";

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<File> createFileOfPdfUrl() async {
    final url = this.widget.url;
    final filename = "termos.pdf";
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Scaffold(
        body: Stack(
          children: [
            loading()
          ],
        ),
      );
    }
    else{
      return PDFViewerScaffold(
          appBar: AppBar(
            //color: const Color(0xFFfdbb79),
            backgroundColor: Color(0xFFfdbb79),
            title: Text(this.widget.title),
            actions: <Widget>[
            ],
          ),
          path: pathPDF);
    }
  }
  Widget loading() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Defaults.primary),
              ),
              SizedBox(height: 20.0,),
              Text(
                "Carregando",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22.0
                ),
              )
            ],
          )
      ),
    );
  }
}