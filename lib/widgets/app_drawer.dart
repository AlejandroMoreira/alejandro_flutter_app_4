import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text("Hello u Dummy!"),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          buildListTile(context, "Shop", Icons.shop, "/"),
          Divider(),
          buildListTile(
              context, "Orders", Icons.payment, OrdersScreen.routeName),
          Divider(),
          buildListTile(context, "Manage Products", Icons.edit,
              UserProductsScreen.routeName),
          Divider(),
        ],
      ),
    );
  }

  ListTile buildListTile(
      BuildContext context, String text, IconData icon, String ruta) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(ruta);
      },
    );
  }
}
