import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  //const ShipCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ExpansionTile(
        title: Text(
          'Cálcular Frete',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          textAlign: TextAlign.start,
        ),
        leading: Icon(Icons.location_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite o seu CEP'),
              initialValue: '',
              onFieldSubmitted: (text) {},
            ),
          ),
        ],
      ),
    );
  }
}
