import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/models/cart_products.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  //busca o usuario atual
  UserModel user;

  //cria a lista do carrinho de compras
  List<CartProduct> products = [];

  String couponCode;
  int discountPercentage = 0;

  bool isLoading = false;

  CartModel(this.user) {
    if (user.isLoggedIn()) _loadCartItems();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    //função carrega todos os produtos do carrinho de compras
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();
    //salva em uma variavel, montando todos os produtos em uma lista
    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

  void setCoupon(String couponCode, int discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getShipPrice() {
    return 9.99;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercentage / 100;
  }

  Future<String> finishOrder() async {
    //esse if verifica se a lista está vazia
    if (products.length == 0) return null;

    //isLoading indica que está carregando os dados do carrinho
    isLoading = true;
    notifyListeners();

    double productPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    //salvando todos os dados do pedido como uma ordem de serviço
    //o refOrder serve para buscar a referencia do id do produto para usa-lo depois
    DocumentReference refOrder =
        await Firestore.instance.collection('orders').add({
      'clientId': user.firebaseUser.uid,
      'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrine': productPrice,
      'discount': discount,
      'totalPrice': productPrice - discount + shipPrice,
      'status': 1
    });

    //nessa função o id do pedido está sendo salvo dentro da pasta do usuário
    await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('orders')
        .document(refOrder.documentID)
        .setData({'orderId': refOrder.documentID});

    //nessa função após a finalização do pedido, todos os produtos vão ser eliminados do carrinho
    //No query vamos listar todos os produtos do carrinho
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    //nesse for vamos pegar cada item do carrinho e passar a referencia de dele e será deletado
    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }
    //limpar a lista local
    products.clear();

    //voltar o disconto para 0 e cupom
    discountPercentage = 0;
    couponCode = null;

    //não estamos mais carregando
    isLoading = false;

    //para finalizar todos os procedimentos vamos notificar todos os listeners
    notifyListeners();

    //retorna o valor do id de numero de ordem
    return refOrder.documentID;
  }
}
