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

  Future<void> fetchAndSetOrders() async {
    const url = "https://alejandro-app-flutter-4.firebaseio.com/orders.json";
    final response = await http.get(url);
    print(json.decode(response.body));
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    if (extractedData == null) return;

    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
        id: key,
        amount: value["amount"],
        products: (value["products"] as List<dynamic>)
            .map((e) => CartItem(
                  id: e["id"],
                  price: e["price"],
                  title: e["title"],
                  quantity: e["quantity"],
                ))
            .toList(),
        dateTime: DateTime.parse(value["dateTime"]),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
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
