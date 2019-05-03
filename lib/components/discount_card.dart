import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  //const DiscountCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
          textAlign: TextAlign.start,
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Digite o seu cupom!'),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection('coupons')
                    .document(text)
                    .get()
                    .then((docSnap) {
                  if (docSnap.data != null) {
                    //cupom existe
                    CartModel.of(context)
                        .setCoupon(text, docSnap.data['percent']);
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${docSnap.data["percent"]}% aplicado"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    //cupom não existe
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Cupom não existente!"),
                        backgroundColor: Colors.red));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
