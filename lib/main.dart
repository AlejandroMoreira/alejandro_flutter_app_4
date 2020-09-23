import 'package:alejandroflutterapp4/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/products_details_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(),
      //Sólo se rebuildearan los widget que hagan listener a esto
      child: MaterialApp(
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
          "": (_) => ProductsOverviewScreen(),
          "/product-detail": (_) => ProductsDetailsScreen(),
        },
      ),
    );
  }
}
