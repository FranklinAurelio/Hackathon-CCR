import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutterapp/main.dart';

bool checkEmail(String email){
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(email);
}

bool validString(String input){
  RegExp regExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]');
  return regExp.hasMatch(input);
  
}

bool validNumber(String input){
  RegExp regExp = RegExp(r'^[0-9]+$');
  return regExp.hasMatch(input);
}

dynamic checkNome(String nome){
  dynamic ret = [false, ''];
  if(nome.length==0){
    ret[0] = true;
    ret[1] = 'Preencha com seu nome completo';
  }
  else if(nome.split(' ').length==1){
    ret[0] = true;
    ret[1] = 'Preencha com nome e sobrenome';
  }
  else if(validString(nome)==false){
    ret[0] = true;
    ret[1] = 'Caracteres inválidos neste campo';
  }
  return ret;
}

dynamic checkRg(String rg){
  dynamic ret = [false, ''];
  if(rg.length==0){
    ret[0] = true;
    ret[1] = 'Preencha com seu RG';
  }
  else if(validNumber(rg)==false){
    ret[0] = true;
    ret[1] = 'Insira apenas os números do RG';
  }
  return ret;
}

dynamic checkCpf(String cpf){
  dynamic ret = [false, ''];
  if(cpf.length==0){
    ret[0] = true;
    ret[1] = 'Preencha com seu CPF';
  }
  else if(validNumber(cpf)==false){
    ret[0] = true;
    ret[1] = 'Insira apenas os números do CPF';
  }
  else if(cpf.length!=11){
    ret[0] = true;
    ret[1] = 'Quantidade de dígitos invalidos no CPF';
  }
  return ret;
}

dynamic checkPhone(String numero){
  dynamic ret = [false, ''];
  if(numero.length==0){
    ret[0] = true;
    ret[1] = 'Preencha com seu número de telefone';
  }
  else if(validNumber(numero)==false){
    ret[0] = true;
    ret[1] = 'Insira apenas números';
  }
  else if(numero.length!=11){
    ret[0] = true;
    ret[1] = 'Insira o DD depois o número';
  }
  return ret;
}

Future<dynamic> SignIn(String email, String senha) async{
  List<List<dynamic>> ret = [[false, ''], [false, '']];
  if(email.length==0){
    ret[0][0] = true;
    ret[0][1] = 'Preencha com seu email';
  }
  else if(checkEmail(email)==false){
    ret[0][0] = true;
    ret[0][1] = 'Email inválido';
  }
  if(senha.length==0){
    ret[1][0] = true;
    ret[1][1] = 'Preencha com sua senha';
  }
  /*if(ret[0][0]==false && ret[1][0]==false){
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);
    }
    catch(error){
      print('error: '+error.toString());
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          {
            print('email não cadastrado');
            ret[0][0] = true;
            ret[0][1] = 'Email não cadastrado';
          }
          break;
        case "ERROR_WRONG_PASSWORD":
          {
            print('senha errada');
            ret[1][0] = true;
            ret[1][1] = 'Senha errrada';
          }
          break;
        default:
          {
            print('something else');
            ret[0][0] = true;
            ret[1][0] = true;
            ret[0][1] = 'Aconteceu algo inesperado';
          }
      }
    }
  }

   */
  return ret;
}

Future<dynamic> signUp(String email, String senha) async{
  List<List<dynamic>> ret = [[false, ''], [false, '']];
  if(email.length==0){
    ret[0][0] = true;
    ret[0][1] = 'Preencha com seu email';
  }
  else if(checkEmail(email)==false){
    ret[0][0] = true;
    ret[0][1] = 'Email inválido';
  }
  if(senha.length==0){
    ret[1][0] = true;
    ret[1][1] = 'Preencha com sua senha';
  }
  else if(senha.length<6){
    ret[1][0] = true;
    ret[1][1] = 'Senha precisa ter 6 ou mais caracteres';
  }
  /*if(ret[0][0]==false && ret[1][0]==false){
    try{
      var userAuth = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);
      await userAuth.user.sendEmailVerification();
    }
    catch(e){
      if(e.code=='ERROR_EMAIL_ALREADY_IN_USE'){
        ret[0][0] = true;
        ret[0][1] = 'Email já registrado';
      }
      else if(e.code=='ERROR_WEAK_PASSWORD'){
        ret[1][0] = true;
        ret[1][1] = 'Senha muito fraca';
      }
      else{
        ret[0][0] = true;
        print(e.code);
      }
    }
  }

   */
  return ret;
}

Future<void> logout() async{
  await FirebaseAuth.instance.signOut();
}
