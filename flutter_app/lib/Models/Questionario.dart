import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/Models/User.dart';

final ref = Firestore.instance.collection('Users');

class Questionario {
  String id;
  String titulo;
  List<String> questoes;
  List<String> respostas;

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
          (respostas.asMap()[2] == "asma" ||
              respostas.asMap()[2] == "enfisema")) {
        return "Se você tiver uma bombinha, utilize-a,e espere alguns minutos, caso a falta de ar persista, procure ajuda médica";
      } else if (respostas.asMap()[3] == "sim" ||
          respostas.asMap()[4] == "sim" ||
          respostas.asMap()[5] == "sim" ||
          respostas.asMap()[6] == "sim" ||
          respostas.asMap()[7] == "sim") {
        return "Seu caso não é urgente, mas um médico deve ser procurado assim que possível";
      }
    } else if (titulo == "Questionário sobre Dor de cabeça") {
      if (respostas.asMap()[3] == "sim" && usuario.idade > 40) {
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
    }
  }
}
