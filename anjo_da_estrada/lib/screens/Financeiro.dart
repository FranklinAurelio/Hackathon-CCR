import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:anjodaestrada/Models/Finances.dart';
import 'package:anjodaestrada/Models/User.dart';
import 'package:anjodaestrada/main.dart';
import 'package:anjodaestrada/utils/defaults.dart';
import 'package:line_icons/line_icons.dart';


class Finances extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FinancesState();
}

class _FinancesState extends State<Finances> {
  FinancesM finances;
  Usuario usuario;

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final input = TextEditingController();
  final output = TextEditingController();

  _adcicionarValor(){
    finances = FinancesM(
      inputs: input.text ,
      outputs: output.text,
      user: usuario.name
    );
  }

  loadInfo() async{
    var saldoTotal = 0;
    var gastos = 0;
    demoData = [

      {
        "title": "Entrada",
        "value": saldoTotal ,
        "icon": LineIcons.money
      },
      {
        "title": "Saida",
        "value": gastos,
        "icon": LineIcons.bank
      },
    ];
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = true;

  List<Map<String, dynamic>> demoData;

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Finanças",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black87,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20.0,),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (BuildContext ctx, int index) {
                        return dashInfo(demoData[index]);
                      },
                      separatorBuilder: (BuildContext ctx, int index) {
                        return SizedBox(height: 10.0);
                      },
                      itemCount: demoData.length
                  ),
                ),

              Container(
              child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 1.0,
                    shadowColor: Colors.black54,
                    child: TextFormField(
                      obscureText: false,
                      controller: input,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontFamily: 'Montserrat', fontSize: 18.0),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                        hintText: "Entrada",
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            color: Colors.black38, fontSize: 18.0),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Material(
                    elevation: 1.0,
                    shadowColor: Colors.black54,
                    child: TextFormField(
                      obscureText: false,
                      controller: output,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontFamily: 'Montserrat', fontSize: 18.0),
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                        hintText: "Saida",
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                            color: Colors.black38, fontSize: 18.0),
                        border: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ),

                  Material(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.red,
                    child: MaterialButton(
                      height: 70.0,
                      minWidth: MediaQuery.of(context).size.width,
                      padding:
                      EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Text("Adicionar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                      onPressed: () async {
                        await _adcicionarValor();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      )
    )
        )
      );
    }
  }

  Widget dashInfo(Map<String, dynamic> data) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: 120,
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color(0xFFe6e6e6)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
            child: Text(
                data["title"],
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                )
            ),
          ),
          Container(
            height: 1,
            color: const Color(0xFFe6e6e6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "R\$ ${data["value"]}",
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold
                    )
                ),
                Icon(
                  data["icon"],
                  size: 40.0,
                  color: Defaults.primary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
