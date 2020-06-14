import 'package:cloud_firestore/cloud_firestore.dart';

class FinancesM {
  String inputs;
  String outputs;
  String user;

  FinancesM({
    this.inputs,
    this.outputs,
    this.user
  });

  fromJson(Map<String, dynamic> json) {
    inputs = json['inputs'];
    outputs = json['outputs'];
    user = json['user'];
  }

  FinancesM.fromJson(Map<String, dynamic> json) {
    inputs = json['inputs'];
    outputs = json['outputs'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inputs'] = this.inputs;
    data['outputs'] = this.outputs;
    data['user'] = this.user;
    return data;
  }
  save() async{
    var ref = Firestore.instance.collection("Finances");
    await ref.document(this.user).setData(toJson());
  }

  reload() async{
    var ref = Firestore.instance.collection("Finances");
    this.fromJson((await ref.document(this.user).get()).data);
  }

}

