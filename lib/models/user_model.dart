import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class UserModel extends Model {
  //usuario atual
  bool isLoading = false;
  //cadastro
  void signUp() {}

  //login
  void signIn() async {
    isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));

    isLoading = false;
    notifyListeners();
  }

  //esqueceu a senha
  void recoverPass() {}

  //manter usuario logado
  bool isLoggedIn() {}
}
