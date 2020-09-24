import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;

  final String removeId;

  const CartItemWidget(
      {this.id, this.price, this.quantity, this.title, this.removeId});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(this.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Are you sure?"),
              content: Text("Do you want to remove $title from the cart?"),
              actions: [
                FlatButton(
                  child: Text("No"),
                  onPressed: (){
                    Navigator.of(context).pop(false);
                  },
                ),FlatButton(
                  child: Text("Yes"),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                ),

              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(removeId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text("\$${price.toStringAsFixed(2)}"),
                  )),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${(price * quantity).toStringAsFixed(2)}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
