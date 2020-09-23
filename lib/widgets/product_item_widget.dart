import 'package:alejandroflutterapp4/screens/products_details_screen.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const ProductItemWidget(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              "/product-detail",
              arguments: id,
            );
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(Icons.favorite),
            color: Theme.of(context).buttonColor,
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
