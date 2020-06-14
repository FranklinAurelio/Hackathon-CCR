import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:anjodaestrada/Models/User.dart';
import 'package:anjodaestrada/main.dart';
import 'package:anjodaestrada/settings/routes.dart';
import 'package:anjodaestrada/utils/defaults.dart';
import 'package:anjodaestrada/Functions/LoginFunction.dart';

import 'pagePdfView.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  Usuario user;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCacheLogin();
  }

  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> _currentUser() async{
    return await _auth.currentUser();
  }

  getCacheLogin() async{
    FirebaseUser current = await _currentUser();

    if(current!=null){
      try {
        print('login em cache, entrando');
        setState(() {
          isLoading = true;
        });



        user = Usuario(id: current.email);
        await user.reload();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
                (Route<dynamic> route) => false);

        isLoading = false;
      } on Exception catch (_){
        setState(() {
          isLoading = false;
        });
      }

    }
    else
      print('sem login em cache');
  }


  final emailController = TextEditingController();
  final pwdController = TextEditingController();

  static String errorMessage = "";

  static bool isLoading = false;

  reloadAndNextScreen() async{
    user = Usuario(id: emailController.text);
    await user.reload();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
            (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 40.0, bottom: 20.0),
                  child: Image.asset("assets/images/logo.png", width: 90),
                ),
                !isLoading
                    ? Container(
                        child: Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              errorMessage,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.0),
                            ),
                            SizedBox(height: 10.0),
                            Material(
                              child: TextFormField(
                                obscureText: false,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 18.0),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 16.0, 20.0, 16.0),
                                  hintText: "Email",
                                  filled: true,
                                  fillColor: const Color(0xFFF0F0F0),
                                  hintStyle: TextStyle(
                                      color: const Color(0xFFa6a6a6),
                                      fontSize: 18.0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFe6e6e6),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFe6e6e6),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Material(
                              child: TextFormField(
                                controller: pwdController,
                                obscureText: true,
                                style: TextStyle(
                                    fontFamily: 'Roboto', fontSize: 18.0),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 16.0, 20.0, 16.0),
                                  hintText: "Senha",
                                  filled: true,
                                  fillColor: const Color(0xFFF0F0F0),
                                  hintStyle: TextStyle(
                                      color: const Color(0xFFa6a6a6),
                                      fontSize: 18.0),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFe6e6e6),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFe6e6e6),
                                          width: 0.5),
                                      borderRadius: BorderRadius.circular(8.0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Material(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.red,
                              child: MaterialButton(
                                height: 60.0,
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                child: Text("Entrar",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600)),
                                onPressed: () async {
                                  String email = emailController.text.toString().trim();
                                String pwd = pwdController.text.toString().trim();

                                if(email != "") {
                                  setState(() {
                                    errorMessage = "";
                                  });
                                  setState(() {
                                    errorMessage = "";
                                  });
                                  if(pwd != "") {
                                    setState(() {
                                      errorMessage = "";
                                      isLoading = true;
                                    });
                                    var flags = await SignIn(email, pwd);
                                    if(flags[0][0]){
                                      setState(() {
                                        errorMessage = flags[0][1];
                                      });
                                    }
                                    else if(flags[1][0]){
                                      setState(() {
                                        errorMessage = flags[1][1];
                                      });
                                    }
                                    else{
                                      setState(() {
                                        errorMessage = "";
                                      });
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    setState(() {
                                      errorMessage = "A senha não pode ser vazia!";
                                    });
                                  }
                                } else {
                                  setState(() {
                                    errorMessage = "O email não pode ser vazio!";
                                  });
                                }


                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                    : loading()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 165.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                child: Text("Ainda não tenho uma conta",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pushNamed(context,
                      AppRoutes.register);
                },
              ),
              SizedBox(
                height: 35.0,
              ),
            ],
          ),
        ),
      ),
    );
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
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Autenticando",
            style: TextStyle(color: Colors.red, fontSize: 22.0),
          )
        ],
      )),
    );
  }
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  Usuario user;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final name = TextEditingController();
  final rg = TextEditingController();
  final cpf = TextEditingController();
  final phone = TextEditingController();

  bool defesaCivel = false;
  bool concordoPrivacidade = false;
  bool concordoUso = false;
  bool promocoes = false;
  bool paradas = false;

  static String errorMessage = "";

  static bool isLoading = false;

  _novoUsuario(){
    user = Usuario(
        id: emailController.text,
        name: name.text,
        email: emailController.text,
        rg: int.tryParse(rg.text),
        cpf: cpf.text,
        phone: int.tryParse(phone.text),
    );
    user.save();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: Image.asset("assets/images/logo.png", width: 100),
              ),
              !isLoading
                  ? Container(
                      child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 18.0),
                          ),
                          SizedBox(height: 20.0),
                          Material(
                            elevation: 1.0,
                            shadowColor: Colors.black54,
                            child: TextFormField(
                              obscureText: false,
                              controller: name,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                hintText: "Nome completo",
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
                              controller: rg,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                hintText: "RG",
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
                              controller: cpf,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                hintText: "CPF",
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
                              controller: phone,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                hintText: "Telefone",
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
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                hintText: "Email",
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
                          SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            elevation: 1.0,
                            shadowColor: Colors.black54,
                            child: TextFormField(
                              controller: pwdController,
                              obscureText: true,
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 18.0),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                hintText: "Senha",
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
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PdfView(
                                            url: termosPrivacidade,
                                            title: "Termos de privacidade",
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: concordoPrivacidade,
                                  onChanged: (value) {
                                    setState(() {
                                      concordoPrivacidade = value;
                                    });
                                  },
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                      "Li e concordo com os termos de privacidade",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: promocoes,
                                  onChanged: (value) {
                                    setState(() {
                                      promocoes = value;
                                    });
                                  },
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                      "Permito receber notificações de promoções",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: paradas,
                                  onChanged: (value) {
                                    setState(() {
                                      paradas = value;
                                    });
                                  },
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                      "Permito receber sugestoes de parada",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: defesaCivel,
                                  onChanged: (value) {
                                    setState(() {
                                      defesaCivel = value;
                                    });
                                  },
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                      "Permito receber notificações da defesa civil",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PdfView(
                                            url: termosdeUso,
                                            title: "Termos de Uso",
                                          )));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Checkbox(
                                  value: concordoUso,
                                  onChanged: (value) {
                                    setState(() {
                                      concordoUso = value;
                                    });
                                  },
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                      "Li e concordo com os termos de uso",
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w600)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.red,
                            child: MaterialButton(
                              height: 70.0,
                              minWidth: MediaQuery.of(context).size.width,
                              padding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              child: Text("Registrar",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()));
                                String email = emailController.text.toString().trim();
                              String pwd = pwdController.text.toString().trim();

                              if(concordoPrivacidade && concordoUso){
                                if(email != "") {
                                  setState(() {
                                    errorMessage = "";
                                  });
                                  setState(() {
                                    errorMessage = "";
                                  });
                                  if(pwd != "") {
                                    setState(() {
                                      errorMessage = "";
                                      isLoading = true;
                                    });
                                    var flag = checkNome(name.text);
                                    if(flag[0]==false){
                                      flag = checkRg(rg.text);
                                      if(flag[0]==false){
                                        flag = checkCpf(cpf.text);
                                        if(flag[0]==false){
                                          flag = checkPhone(phone.text);
                                          if(flag[0]==false){
                                            var flags = await signUp(email, pwd);
                                            if(flags[0][0]){
                                              setState(() {
                                                errorMessage = flags[0][1];
                                              });
                                            }
                                            else if(flags[1][0]){
                                              setState(() {
                                                errorMessage = flags[1][1];
                                              });
                                            }
                                            else{
                                              setState(() {
                                                errorMessage = "";
                                              });
                                            }

                                            if(errorMessage==""){
                                              await _novoUsuario();
                                            }
                                          }
                                          else{
                                            setState(() {
                                              errorMessage = flag[1];
                                            });
                                          }
                                        }
                                        else{
                                          setState(() {
                                            errorMessage = flag[1];
                                          });
                                        }
                                      }
                                      else{
                                        setState(() {
                                          errorMessage = flag[1];
                                        });
                                      }
                                    }
                                    else{
                                      setState(() {
                                        errorMessage = flag[1];
                                      });
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                    /*
                                  UsersService service = UsersService();
                                  final result = service.auth(email, pwd);
                                  result.then((UserModel response) async {
                                    if(response.status == 200) {
                                      SessionStorage.user = response.data.user;
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Base())
                                      );
                                    } else {
                                      setState(() {
                                        errorMessage = "Email ou senha incorretos.";
                                        isLoading = false;
                                      });
                                    }
                                  });
                                   */
                                  } else {
                                    setState(() {
                                      errorMessage = "A senha não pode ser vazia!";
                                    });
                                  }
                                } else {
                                  setState(() {
                                    errorMessage = "O email não pode ser vazio!";
                                  });
                                }
                              }


                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          InkWell(
                            child: Text("Já tenho conta",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w600)),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ))
                  : loading()
            ],
          ),
        ),
      ),
    );
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
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Autenticando",
            style: TextStyle(color: Colors.red, fontSize: 22.0),
          )
        ],
      )),
    );
  }
}
