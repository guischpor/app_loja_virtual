import 'package:ecommerce_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  bool _validate = false;

  final emailController = TextEditingController();

  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text('CRIAR CONTA',
                style: TextStyle(
                  fontSize: 15.0,
                )),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
          ),
        ],
      ),
      body: Form(
        autovalidate: _validate,
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: 'E-mail'),
              keyboardType: TextInputType.emailAddress,
              // validator: (text) {
              //   if (text.isEmpty || !text.contains("@"))
              //     return 'E-mail inválido!';
              // },
              validator: _validateEmail,
              controller: emailController,
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
              controller: senhaController,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Text(
                    'Esquecei minha senha',
                    textAlign: TextAlign.right,
                  ),
                )),
            SizedBox(height: 16.0),
            SizedBox(
              height: 44.0,
              child: RaisedButton(
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                color: primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
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
      ),
    );
  }

  String _validateEmail(String text) {
    if (text.length == 0 || !text.contains('@')) {
      return 'E-mail Inválido';
    } else {
      return null;
    }
  }

  String _validateSenha(String text) {
    if (text.length == 0) {
      return 'Preencha o Campo';
    }
    if (text.length < 6) {
      return 'A senha deve ter no minimo 6 caracteres';
    } else {
      return null;
    }
  }
}
