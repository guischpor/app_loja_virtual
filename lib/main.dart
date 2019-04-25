import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Flutter's Clothinf",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141)),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
