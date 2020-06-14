import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/Models/Questionario.dart';
import 'package:flutterapp/screens/questoes/bloc.dart';
import 'package:flutterapp/settings/routes.dart';
import 'package:flutterapp/utils/defaults.dart';
import 'package:flutterapp/widgets/background_image.dart';
import 'package:flutterapp/widgets/button.dart';

class QuestoesList extends StatefulWidget {
  @override
  _QuestoesListState createState() => _QuestoesListState();
}

class _QuestoesListState extends State<QuestoesList> {
  Questionario questionario;
  final bloc = QuestoesBloc();

  int index = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    questionario = ModalRoute.of(context).settings.arguments;
  }

  TextStyle get h6 => Theme.of(context).textTheme.headline6;

  TextStyle get body => Theme.of(context).textTheme.bodyText1.apply(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const BackgroundImageWidget(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    questionario.titulo,
                    style: h6,
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: bloc.listenable,
                    builder: (context, value, _) {
                      return Card(
                        color: Defaults.red,
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                questionario.questoes.asMap()[index].toString(),
                                style: body,
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    child: RadioListTile(
                                      activeColor: Colors.white,
                                      title: Text('Sim', style: body,),
                                      value: 'Sim',
                                      groupValue: value,
                                      onChanged: (newValue) =>
                                          bloc.answer = newValue,
                                    ),
                                  ),
                                  Expanded(
                                    child: RadioListTile(
                                      title: Text('Não', style: body,),
                                      activeColor: Colors.white,
                                      value: 'Não',
                                      groupValue: value,
                                      onChanged: (newValue) =>
                                          bloc.answer = newValue,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 24.0,
                              ),
                              ButtonWidget(
                                color: Colors.white,
                                onPressed: value != null ? () {} : null,
                                child: Text('Enviar'),
                              ),
                               SizedBox(height: questionario.id == "4" ? 24.0 : 0,),
                              questionario.id == "4" ? ButtonWidget(
                                onPressed: () => Navigator.pushNamed(context, AppRoutes.panico),
                                color: Colors.white,
                                child: Text("Panico"),
                              ) : const SizedBox(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
