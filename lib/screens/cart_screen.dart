import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "\$${cartData.totalAmount}",
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline6
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  FlatButton(
                    child: Text("ORDER NOW"),
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CartItemWidget(
                  id: cartData.items.values.toList()[index].id,
                  quantity: cartData.items.values.toList()[index].quantity,
                  price: cartData.items.values.toList()[index].price,
                  title: cartData.items.values.toList()[index].title,
                  removeId: cartData.items.keys.toList()[index]);
              },
              itemCount: cartData.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
