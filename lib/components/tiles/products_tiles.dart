import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/products_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTile extends StatelessWidget {
  //const ProductsTiles({Key key}) : super(key: key);

  final String type;
  final ProductData data;
  ProductTile(this.type, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
