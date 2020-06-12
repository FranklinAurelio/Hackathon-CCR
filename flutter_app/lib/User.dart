import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

final ref = Firestore.instance.collection('Users');

final ganhoEntrega = 5.00;

class Usuario {
  String id;
  String name;
  String email;
  int rg;
  String cpf;
  String genero;
  int phone;
  String picture;
  List<double> lat_lng;

  Usuario(
      {this.id,
        this.name,
        this.email,
        this.rg,
        this.cpf,
        this.genero,
        this.phone,
        this.picture,
        this.lat_lng});

  fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.rg = json['rg'];
    this.cpf = json['cpf'];
    this.genero = json['genero'];
    this.phone = json['phone'];
    this.picture = json['picture'];
    if(json.containsKey('lat_lng'))
      if(json['lat_lng']!=null)
        this.lat_lng = json['lat_lng'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['rg'] = this.rg;
    data['cpf'] = this.cpf;
    data['genero'] = this.genero;
    data['phone'] = this.phone;
    data['picture'] = this.picture;
    data['lat_lng'] = this.lat_lng;
    return data;
  }

  save() async{
    await ref.document(this.id).setData(toJson());
  }

  reload() async{
    this.fromJson((await ref.document(this.id).get()).data);
    print('usuário recarregado');
  }

  setPosition(Position location) async{
    this.lat_lng = [location.latitude, location.longitude];
    await this.save();
  }
}