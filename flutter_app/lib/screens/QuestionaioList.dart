import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/Models/Questionario.dart';
import 'package:flutterapp/settings/routes.dart';
import 'package:flutterapp/widgets/background_image.dart';

class QuestionarioList extends StatelessWidget {
  List<Questionario> _questionarios = new List();
  List<QuestionarioItem> _items = new List();

  QuestionarioList() {
    buscarDados();
    loadQuestionarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const BackgroundImageWidget(),
          SafeArea(
            child: ListView.builder(
                itemCount: _questionarios.length,
                padding: const EdgeInsets.only(top: 5.0),
                itemBuilder: (context, index) {
                  final questionario = _items[index].questionario;
                  return FlatButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.questoes,
                        arguments: questionario,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _items[index],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  void loadQuestionarios() {
    _questionarios.forEach((item) {
      var questionario = new QuestionarioItem(item);
      _items.add(questionario);
    });
  }

  void buscarDados() {
    List<String> questoes = [
      "Você teve febre por mais de dois dias?",
      "Você teve febre por mais de dois dias?",
      "Se sente sonolento ?",
      "Hoje você urinou menos do que o normal?",
      "Teve dor no corpo e pontas vermelhas? (Dengue)",
      "Teve sintomas como Nariz entupido, produção de catarro?"
    ];
    _questionarios.add(Questionario(
        id: "1",
        titulo: "Questionário sobre Febre",
        descricao: "Questionário relacionado a sintomas como febre",
        questoes: questoes));

    questoes = [
      "A falta de ar está associada a febre, tosse, dor e pontada no peito ?",
      "Você tem alguma doença do pulmão como asma ou enfisema?",
      "A falta de ar dificulta muito a respiração?",
      "Você consegue falar normalmente?",
      "Você se sente sonolento ?",
      "Seus dedos estão azuis?",
      "A falta de ar já é de longa data e está associada somente à atividades físicas, tais como subir escadas, levantar uma caixa ou caminhar? "
    ];
    _questionarios.add(Questionario(
        id: "2",
        titulo: "Questionário sobre falta de ar",
        descricao: "Questionário relacionado a sintomas como falta de ar",
        questoes: questoes));

    questoes = [
      "Você já estava com dor de cabeça e ela piorou muito? ",
      "A dor de cabeça não melhora com analgésicos, como Dipirona e Paracetamol?",
      "A dor de cabeça é de forte intensidade e começou muito rápido?",
      "Você apresenta sintomas como febre, perda de peso recente, manchas na pele, dor nas costas ou no pescoço ao mexer a cabeça?",
      "Você está com a visão embaçada e ou sonolência fora do normal?",
      "Caso você tenha enxaqueca, a dor de cabeça agora parece mais forte do que as que você já teve antes?",
      "Você está com fraqueza em algum braço ou perna?"
    ];
    _questionarios.add(Questionario(
        id: "3",
        titulo: "Questionário sobre Dor de cabeça",
        descricao: "Questionário relacionado a sintomas como dor de cabeça",
        questoes: questoes));

    questoes = [
      "A dor é difusa ou imprecisa?",
      "A dor é constante, de forte intensidade e em aperto?",
      "A dor já dura mais de 30 minutos?",
      "A dor tem alguma dessas características? espalha para o braço esquedo, pescoço,ou estomago, Espalha para as costas,Piora com a respiração,Sensação de rasgar,Dor em fincada",
      "Você teve algum desses sintomas além da dor? Falta de ar, vômito, febre, tosse."
    ];
    _questionarios.add(Questionario(
        id: "4",
        titulo: "Questionário sobre Dor no peito",
        descricao: "Questionário relacionado a sintomas como dor no peito",
        questoes: questoes));

    questoes = [
      "Você teve algum desses sintomas? Febre, vômito.",
      "A dor começou de uma hora para outra, com forte intensidade?",
      "Fez alguma cirurgia recente na barriga?",
      "Você costuma beber muito?",
      "Você está no início de uma gravidez?",
      "A dor apresenta alguma dessas características?Localizada no lado superior direito, em pontada, Localizada no lado inferior direito, piora ao levantar a perna direita, em faixa, pegando todo o andar superior do abdome, associada ou não à vômitos",
      "Você está há mais de 3 dias sem fazer cocô?",
      "A dor é difusa, em cólica e você está com diarreia?"
    ];
    _questionarios.add(Questionario(
        id: "5",
        titulo: "Questionário sobre Dor na Barriga",
        descricao: "Questionário relacionado a sintomas como dor na barriga",
        questoes: questoes));

    questoes = [
      "Caso você tenha dores frequentes nas costas, a dor agora é mais forte do que você sente habitualmente?",
      "Você teve algum desses sintomas?Febre persistente, Suadeira noturna, Perda de peso importante",
      "A dor se espalha para as pernas?",
      "Você consegue sentir seus braços e pernas normalmente? Se quiser, faça o teste e toque seus membros",
      "Você está com dificuldade para andar?",
      "Você está com manchas marrons e ou nódulos pelo corpo?"
    ];
    _questionarios.add(Questionario(
        id: "6",
        titulo: "Questionário sobre Dor nas costas",
        descricao: "Questionário relacionado a sintomas como dor nas costas",
        questoes: questoes));

    questoes = [
      "Você sentiu falta de ar antes ou depois do desmaio?",
      "Você teve palpitações (batedeira no coração) antes de desmaiar?",
      "Você desmaiou enquanto estava se exercitando ou fazendo esforço? ",
      "Você desmaiou enquanto estava deitado de barriga para cima? ",
      "Você teve algum desses sintomas logo antes de desmaiar?Enjoo, vômito, desconforto na barriga, dor nos ombros ou pescoço, visão embaçada, claridade na visão, tontura.",
      "Você estava em um local muito quente ou com muita gente quando desmaiou?",
      "Você ficou muito tempo de pé antes de desmaiar? ",
      "Você passou por uma emoção muito forte, como raiva, medo ou espanto antes de desmaiar? ",
      "Você sentiu uma dor muito forte que o fez desmaiar?"
    ];
    _questionarios.add(Questionario(
        id: "7",
        titulo: "Questionário sobre desmaio",
        descricao: "Questionário relacionado a sintomas como desmaio",
        questoes: questoes));

    questoes = [
      "Você chegou a vomitar mais de 10 vezes num dia? ",
      "Os vômitos já duram mais de uma semana?",
      "Há sangue no vômito?",
      "Você está há mais de 3 dias sem fazer cocô?",
      "Você tem algum desses sintomas?Sede intensa, olhos fundos, diminuição da quantidade de xixi?",
      "Você tem dor em algum desses locais? Dor no lado superior direito da barriga, em pontada, Dor no lado inferior direito da barriga, que piora ao levantar a perna direita,Dor forte em toda a parte superior do abdome (+ história de alcoolismo)",
      "Você está com dor de cabeça forte?",
      "Você está com uma forte dor no peito há mais de meia hora?",
      "Me diga se além do vômito, você teve esses sintomas: Febre, pele e olhos amarelados,fraqueza,falta de apetite,diarreia,dor no corpo,dor de cabeça",
      "Você notou que sua pele está acinzentada?"
    ];
    _questionarios.add(Questionario(
        id: "8",
        titulo: "Questionário sobre Vômito",
        descricao: "Questionário relacionado a sintomas como vômito",
        questoes: questoes));

    questoes = [
      "Você está com diarreia há mais de 2 semanas?",
      "Você está indo ao banheiro 10 ou mais vezes por dia devido à diarreia e vômito?",
      "Está vindo sangue junto ao cocô?",
      "Você tem algum desses sintomas?Diminuição do xixi, sede intensa, sonolência fora do normal, olhos fundos, febre alta.",
      "Você sente vontade de ir ao banheiro, mas não sai nada?",
      "Além da diarreia, você sente uma dor de barriga muito forte e com sensação diferente das que já teve antes?"
    ];
    _questionarios.add(Questionario(
        id: "9",
        titulo: "Questionário sobre Diarreia",
        descricao: "Questionário relacionado a sintomas como diarréia",
        questoes: questoes));


    questoes = [
      "Pouco interesse ou pouco prazer em fazer as coisas",
      "Se sentir pra baixo, deprimido ou sem perspectiva",
      "Dificuldade em pegar no sono ou permanecer dormindo, ou dormir mais que o de costume",
      "Se sentir cansado ou com pouca energia",
      "Falta de apetite ou comendo demais",
      "Se sentir mal consigo mesmo(a), ou achar que você é um fracasso ou que decepcionou sua família ou você mesmo(a)",
      "Dificuldade para se concentrar nas coisas, como ler o jornal ou ver televisão",
      "Lentidão para se movimentar ou falar, a ponto das outras pessoas perceberem? Ou o oposto, estar tão agitado(a) que você fica andando de um lado para o outro muito mais do que de costume",
      "Pensar em se ferir de alguma maneira ou que seria melhor estar morto(a)"
    ];
    _questionarios.add(Questionario(
        id: "10",
        titulo: "Questionário sobre Depressão",
        descricao: "Questionário relacionado a sinais de depressão",
        questoes: questoes));

    questoes = [
      "Dormência ou formigamento",
      "Sensação de calor",
      "Tremores nas pernas",
      "Incapaz de relaxar",
      "Medo de que aconteça o pior",
      "Atordoado ou tonto",
      "Palpitação ou aceleração do coração",
      "Sem equilíbrio",
      "Aterrorizado",
      "Nervoso",
      "Sensação de sufocação",
      "tremores nas mãos",
      "Trêmulo",
      "Medo de perder o controle",
      "dificuldade de respirar",
      "Medo de morrer",
      "Assustado",
      "Indigestão ou desconforto abdominal",
      "Sensação de desmaio",
      "Rosto afogueado",
      "Suor (não devido ao calor)"
    ];
    _questionarios.add(Questionario(
        id: "11",
        titulo: "Questionário sobre Ansiedade",
        descricao: "Questionário relacionado a sinais de ansiedade",
        questoes: questoes));

  }
}

class QuestionarioItem extends StatelessWidget {
  Questionario questionario;

  QuestionarioItem(this.questionario);

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    this._context = context;

    //Foi adicionado dentro de Container para adicionar margem no item
    return new Container(
      margin: const EdgeInsets.only(
          left: 10.0, right: 10.0, bottom: 10.0, top: 0.0),
      child: new Material(
        borderRadius: new BorderRadius.circular(6.0),
        elevation: 2.0,
        child: _getListTile(questionario, context),
      ),
    );
  }
}

Widget _getListTile(Questionario questionario, BuildContext context) {
  return new Container(
    height: 95.0,
    child: new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _getColumText(questionario, context),
        ),
      ],
    ),
  );
}

Widget _getColumText(Questionario questionario, BuildContext context) {
  return new Container(
    margin: new EdgeInsets.all(10.0),
    child: new Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _getTitleWidget(questionario.titulo),
        _getDescriptionWidget(questionario.descricao)
      ],
    ),
  );
}

Widget _getTitleWidget(String titulo) {
  return new Text(
    titulo,
    maxLines: 1,
    style: new TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget _getDescriptionWidget(String descricao) {
  return new Container(
    margin: new EdgeInsets.only(top: 5.0),
    child: new Text(
      descricao,
      maxLines: 2,
    ),
  );
}
