import 'package:ecommerce_app/models/products_data.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  //ProductScreen({Key key}) : super(key: key);

  final ProductData product;

  ProductScreen(this.product);

  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: null,
    );
  }
}
