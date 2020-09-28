import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async{
    final url =
        "https://alejandro-app-flutter-4.firebaseio.com/products/orders.json";
    final response = await http.get(url);
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = "https://alejandro-app-flutter-4.firebaseio.com/orders.json";
    final timeStamp =
        DateTime.now(); //para tener el mismo tiempo local que en el servidor

    final response = await http.post(url,
        body: jsonEncode({
          "amount": total,
          "dateTime": timeStamp.toIso8601String(),
          "products": cartProducts
              .map((e) => {
                    "id": e.id,
                    "title": e.title,
                    "quantity": e.quantity,
                    "price": e.price,
                  })
              .toList(),
        }));

    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)["name"],
          amount: total,
          dateTime: timeStamp,
          products: cartProducts,
        ));
    notifyListeners();
  }
}
