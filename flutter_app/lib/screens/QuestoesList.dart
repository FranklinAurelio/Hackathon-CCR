import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/Questionario.dart';

class QuestoesList extends StatefulWidget {
  @override
  _QuestoesListState createState() => _QuestoesListState();
}

class _QuestoesListState extends State<QuestoesList> {
  Questionario questionario;

  int index = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    questionario = ModalRoute.of(context).settings.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(questionario.titulo),
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(children: <Widget>[
              _getQuestao(),
            ])));
  }

  Widget _getQuestao() {
    return new Container(
        height: 95.0,
        child: new Text(questionario.questoes.asMap()[index].toString()));
  }
}
