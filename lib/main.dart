import 'package:alejandroflutterapp4/screens/products_details_screen.dart';
import 'package:alejandroflutterapp4/screens/products_overview_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        accentColor: Colors.lightBlueAccent,
        buttonColor: Colors.red,
        canvasColor: Color.fromRGBO(255, 255, 234, 1),
        fontFamily: "Laton",
      ),
      home: ProductsOverviewScreen(),
      routes: {
        "" : (_) => ProductsOverviewScreen(),
        "/product-detail" : (_) => ProductsDetailsScreen(),
      },
    );
  }
}
