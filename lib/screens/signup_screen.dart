import 'package:ecommerce_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _validate = false;

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar Conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Form(
            autovalidate: _validate,
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nome Completo'),
                  keyboardType: TextInputType.text,
                  validator: _validateNome,
                  controller: _nomeController,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  // validator: (text) {
                  //   if (text.isEmpty || !text.contains("@"))
                  //     return 'E-mail inválido!';
                  // },
                  validator: _validateEmail,
                  controller: _emailController,
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Senha'),
                  obscureText: true,
                  // validator: (text) {
                  //   if (text.isEmpty || text.length < 6) return 'Senha inválida!';
                  // },
                  validator: _validateSenha,
                  controller: _senhaController,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Endereço'),
                  keyboardType: TextInputType.text,
                  validator: _validateEndereco,
                  controller: _enderecoController,
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    child: Text(
                      'Criar Conta',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nomeController.text,
                          "email": _emailController.text,
                          "address": _enderecoController.text
                        };

                        model.signUp(
                            userData: userData,
                            pass: _emailController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      } else {
                        setState(() {
                          _validate = true;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //validações
  String _validateNome(String text) {
    if (text.length == 0) {
      return 'Nome Inválido!';
    } else {
      return null;
    }
  }

  String _validateEmail(String text) {
    if (text.length == 0 || !text.contains('@')) {
      return 'E-mail Inválido!';
    } else {
      return null;
    }
  }

  String _validateSenha(String text) {
    if (text.length == 0) {
      return 'Preencha o Campo!';
    }
    if (text.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres!';
    } else {
      return null;
    }
  }

  String _validateEndereco(String text) {
    if (text.length == 0) {
      return 'Endereço Inválido!';
    } else {
      return null;
    }
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Usuário criando com sucesso!'),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('Falha ao criar o usuário!'),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
