import 'package:ecommerce_app/components/custom_drawer.dart';
import 'package:ecommerce_app/screens/tabs/home_tab.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer()
        )
      ],
    );
  }
}
