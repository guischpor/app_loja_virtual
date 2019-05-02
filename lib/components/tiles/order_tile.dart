import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  //const OrderTile({Key key}) : supe//r(key: key);

  String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Text(orderId),
    );
  }
}
