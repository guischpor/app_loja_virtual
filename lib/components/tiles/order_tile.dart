import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  //const OrderTile({Key key}) : supe//r(key: key);

  String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              int status = snapshot.data['status'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Código do pedido: ${snapshot.data.documentID}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(_buildProductsText(snapshot.data)),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    'Status do pedido:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buidCircle(
                          status: status,
                          subtitle: 'Preparação',
                          thisStatus: 1,
                          title: '1'),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buidCircle(
                          status: status,
                          subtitle: 'Transporte',
                          thisStatus: 2,
                          title: '2'),
                      Container(
                        height: 1.0,
                        width: 40.0,
                        color: Colors.grey[500],
                      ),
                      _buidCircle(
                          status: status,
                          subtitle: 'Entrega',
                          thisStatus: 3,
                          title: '3'),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  //função que constroe o texto do produto
  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n';
    for (LinkedHashMap p in snapshot.data['products']) {
      text +=
          "${p['quantity']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n";
    }

    text += "Total: R\$ ${snapshot.data['totalPrice'].toStringAsFixed(2)}";
    return text;
  }

  //Widget de progresso do pedido
  Widget _buidCircle(
      {@required String title,
      @required String subtitle,
      @required int status,
      @required int thisStatus}) {
    Color backColor;
    Widget child;

    //1-possibilidade do status ser menor que o thisStatus
    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    }
    //2 - possibilidade do status ser iguaL ao thisStatus
    else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    }
    //3 - possibilidade, caso o pedido esteja concluido o circulo ficará verde
    else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    //retornando a construção do widget
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );
  }
}
