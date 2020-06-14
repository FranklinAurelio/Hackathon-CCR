import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:anjodaestrada/Models/User.dart';

final ref = Firestore.instance.collection('Users');

class Questionario {
  String id;
  String titulo;
  List<String> questoes;
  List<String> respostas = new List();

  //Injetar usuaio logado
  Usuario usuario;
  String descricao;

  Questionario({this.id, this.titulo, this.questoes, this.descricao});

  Questionario.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.titulo = json['titulo'];
    this.questoes = json['questoes'];
    this.respostas = json['respostas'];
  }

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.titulo = json['titulo'];
    this.questoes = json['questoes'];
    this.respostas = json['respostas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = this.id;
    json['titulo'] = this.titulo;
    json['questoes'] = this.questoes;
    json['respostas'] = this.respostas;
    return json;
  }

  Future<void> save() async {
    await ref.document(this.id).setData(toJson());
  }

  Future<void> reload() async {
    this.fromJson((await ref.document(this.id).get()).data);
    print('usuário recarregado');
  }

  void reponder(String reposta) {
    respostas.add(reposta);
  }

  String getResultado() {
    if (titulo == "Questionário sobre falta de ar") {
      if (respostas.asMap()[1] == "sim" &&
          (respostas.asMap()[2] == "sim")) {
        return "Se você tiver uma bombinha, utilize-a,e espere alguns minutos, caso a falta de ar persista, procure ajuda médica";
      } else if (respostas.asMap()[3] == "sim" ||
          respostas.asMap()[4] == "sim" ||
          respostas.asMap()[5] == "sim" ||
          respostas.asMap()[6] == "sim" ||
          respostas.asMap()[7] == "sim") {
        return "Seu caso é grave,um médico deve ser procurado o quanto antes";
      }
    } else if (titulo == "Questionário sobre Dor de cabeça") {
      if (respostas.asMap()[3] == "sim") {
        return "Você apresenta sintomas de cefaleia intensa, procure um médico assim que possível";
      } else if (respostas.asMap()[0] == "sim" ||
          respostas.asMap()[2] == "sim" ||
          respostas.asMap()[4] == "sim" ||
          respostas.asMap()[5] == "sim") {
        return "Você apresenta sintomas graves, procure um médico";
      }
    } else if (titulo == "Questionário sobre febre") {
      if (titulo == "Questioário febre") {
        if (respostas.asMap()[0] == "sim" ||
            respostas.asMap()[1] == "sim" ||
            respostas.asMap()[2] == "sim" ||
            respostas.asMap()[3] == "sim" && respostas.asMap()[4] == "sim") {
          return "Você apresenta sintomas de dengue, procure um posto médico ou a telemedicina";
        } else if (respostas.asMap()[0] == "sim" ||
            respostas.asMap()[1] == "sim" ||
            respostas.asMap()[2] == "sim" ||
            respostas.asMap()[3] == "sim") {
          return "Recomendamos que procure um médico ou a telemedicina assim que possível";
        } else if (respostas.asMap()[5] == "sim") {
          return "O seus sintomas indicam apenas uma infecção leve, caso persistam os sintomas, um médico deverá ser consultado";
        }
      }
    } else if (titulo == "Questionário sobre Dor no peito") {
      if (respostas.asMap()[1] == "sim" ||
          respostas.asMap()[2] == "sim" ||
          respostas.asMap()[3] == "sim") {
        return "Seu caso é grave, você precisa de avaliação médica imediata, aperte o botão do pânico";
      } else {
        return "Seu caso parece não ser grave, mas caso piore procure ajuda médica ou refaça o teste";
      }
    } else if (titulo == "Questionário sobre Dor na Barriga") {
      if (respostas.asMap()[0] == "sim" ||
          respostas.asMap()[1] == "sim" ||
          respostas.asMap()[2] == "sim" ||
          respostas.asMap()[3] == "sim" ||
          respostas.asMap()[4] == "sim" ||
          respostas.asMap()[5] == "sim" ||
          respostas.asMap()[6] == "sim") {
        return " Você precisa de ajuda médica imediata, entre em contato com um médico ou com a telemedicia";
      } else if (respostas.asMap()[7] == "sim") {
        return "Você pode estar com infecção intestinal, beba bastante água e se a diarreia for muito frequente, ou durar mais que uma semana, procure ajuda médica";
      } else {
        return "Sua dor não tem sinais de gravidade, mas se ela piorar muito ou você sentir que precisa de ajuda, aperte o botão do pânico ";
      }
    } else if (titulo == "Questionário sobre Dor nas costas") {
      if (respostas.asMap()[0] == "sim" ||
          respostas.asMap()[1] == "sim" ||
          respostas.asMap()[3] == "sim" ||
          respostas.asMap()[4] == "não" ||
          respostas.asMap()[5] == "sim" ||
          respostas.asMap()[6] == "sim") {
        return "Você precisa de ajuda médica o mais rápido possível, entre em contato com a telemedicina";
      } else {
        return "A sua dor pode ser relacionada à muito tempo sentado, falta de exercícios ou carregar excesso de peso, veja se ela não melhora com relaxantes musculares ou remédios para dor. "
            "Caso ela piore, procure um médico ou refaça o teste.";
      }
    } else if (titulo == "Questionário sobre desmaio") {
      if (respostas.asMap()[0] == "sim" ||
          respostas.asMap()[1] == "sim" ||
          respostas.asMap()[2] == "sim" ||
          respostas.asMap()[3] == "sim" ||
          respostas.asMap()[4] == "não") {
        return "Você precisa procurar um médico o quanto antes, de preferência acompanhado, se sentir que irá desmaiar novamente e estiver sozinho, aperte o botão do pânico.";
      } else {
        return "o seu desmaio não tem características de gravidade, mas é aconselhável procurar um médico. Se você estava sozinho, pode ter batido a cabeça. Nesse caso, vai precisar de avaliação médica o quanto antes.";
      }
    } else if (titulo == "Questionário sobre Vômito") {
      if (respostas.asMap()[3] == "sim" ||
          respostas.asMap()[4] == "sim" ||
          respostas.asMap()[5] == "sim" ||
          respostas.asMap()[6] == "sim" ||
          respostas.asMap()[7] == "sim") {
        return "A sua condição precisa de avaliação médica o quanto antes, use nosso canal de teleconsulta ou procure uma UPA ou hospital.";
      } else {
        return "Você pode estar com intoxicação alimentar, beba bastante água, se alimente na medida do possível, evitando refrigerantes, frituras e gorduras, e se os sintomas piorarem, procure ajuda médica.";
      }
    } else if (titulo == "Questionário sobre Diarreia") {
      if (respostas.asMap()[2] == "sim" || respostas.asMap()[5] == "sim") {
        return "Você precisa de avaliação médica o quanto antes, contate -nos pela teleconsulta ou procure atendimento pessoalmente.";
      } else {
        return "Você provavelmente está com uma infecção intestinal, beba bastante água e lave as mãos frequentemente. Se a diarreia não melhorar, ou se os sintomas piorarem, procure ajuda médica.";
      }
    } else if (titulo == "Questionário sobre Depressão") {
      respostas.removeWhere((element) => element != "sim");
      if (respostas.asMap().length >= 5){
        return "Provável depressão: Você precisa ser avaliado por um médico. Se você está se sentindo triste ou sem esperança, saiba que médicos e psicólogos podem lhe oferecer todo o apoio necessário. "
            "Contate a teleconsulta do aplicativo ou, se você estiver muito mal, ligue para o número 188, lá pessoas qualificadas podem conversar com você a qualquer hora do dia sobre como está se sentindo.";
      } else {
        return "Você não precisa ser avaliado por um médico no momento, mas se quiser, pode ligar na teleconsulta e a equipe de saúde irá lhe ouvir.";
      }
    } else if (titulo == "Questionário sobre Ansiedade") {
      respostas.removeWhere((element) => element != "sim");
      if (respostas.asMap().length >=7) {
        return "Você está com uma ansiedade importante, e precisa procurar ajuda médica, principalmente se você estiver passando por uma situação difícil na sua vida. "
            "Nós queremos lhe ajudar a ter qualidade de vida, não sinta vergonha em ligar na teleconsulta.";
      } else {
        return "Você não parece estar com uma ansiedade importante, mas se você se sente preocupado a ponto de estar atrapalhando a sua vida, procure ajuda médica.";
      }
    }
  }
}
