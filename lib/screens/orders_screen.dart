import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/order_item_widget.dart';
import '../providers/orders.dart';

class OrdersScreen extends StatelessWidget{
  static const routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return OrderItemWidget(
            ordersData.orders[index],
          );
        },
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
