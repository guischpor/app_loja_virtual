import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/components/tiles/order_tile.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //1 - essa função verificará se o usuario está logado
    if (UserModel.of(context).isLoggedIn()) {
      //devemos pegar o uid do usuario logado
      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection('users')
            .document(uid)
            .collection('orders')
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            return ListView(
              children: snapshot.data.documents
                  .map((doc) => OrderTile(doc.documentID))
                  .toList(),
            );
          }
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Faça o login para acompanhar os seus pedidos!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text(
                'Entrar',
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      );
    }
  }
}
