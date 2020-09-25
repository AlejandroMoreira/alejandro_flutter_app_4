import 'package:alejandroflutterapp4/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit-product";

  EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  var _product =
      Product(title: "", price: 0, id: null, imageUrl: "", description: "");

  var _isInit = true;
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": "",
  };

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImage);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;

      if (productId != null) {
        _product =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          "title": _product.title,
          "description": _product.description,
          "price": _product.price.toString(),
          "imageUrl": "",
        };
        _imageUrlController.text = _product.imageUrl;
      }
    }

    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //OBRIGADO
    _imageFocusNode.removeListener(_updateImage);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImage() {
    if (!_imageFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _keyForm.currentState.validate();
    if (!isValid) return;

    _keyForm.currentState.save();
    if (_product.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_product.id, _product);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_product);
    }
    // print(
    //     "title: ${_product.title}\ndescription: ${_product.description}\nprice: ${_product.price}\nurl: ${_product.imageUrl}\n");
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _keyForm,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues["title"],
                decoration: InputDecoration(labelText: "Title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) return "Please enter a Title.";
                  return null; // = a no hay errores
                },
                onSaved: (value) {
                  _product = Product(
                    title: value,
                    price: _product.price,
                    id: _product.id,
                    description: _product.description,
                    imageUrl: _product.imageUrl,
                    isFavorite: _product.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues["price"],
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                validator: (value) {
                  if (value.isEmpty) return "Please enter a Price.";
                  if (double.tryParse(value) == null)
                    return "Please enter a valid number.";
                  if (double.tryParse(value) <= 0)
                    return "Please enter a number greater than zero.";
                  return null;
                },
                onSaved: (value) {
                  _product = Product(
                    title: _product.title,
                    price: double.parse(value),
                    id: _product.id,
                    description: _product.description,
                    imageUrl: _product.imageUrl,
                    isFavorite: _product.isFavorite,
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: InputDecoration(labelText: "Description"),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty) return "Please enter a Description.";
                  return null;
                },
                onSaved: (value) {
                  _product = Product(
                    title: _product.title,
                    price: _product.price,
                    id: _product.id,
                    description: value,
                    imageUrl: _product.imageUrl,
                    isFavorite: _product.isFavorite,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text("Enter a URL")
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ), //Image
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: "Image URL"),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: (value) {
                        if (value.isEmpty) return "Please enter an image URL.";
                        if (!value.startsWith("http") &&
                            !value.startsWith("https"))
                          return "Please enter a valid URL.";
                        if (!value.endsWith(".png") &&
                            !value.endsWith(".jpg") &&
                            !value.endsWith(".jpeg") &&
                            !value.endsWith(".gif")) {
                          return "Please enter a valid image URL";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _product = Product(
                          title: _product.title,
                          price: _product.price,
                          id: _product.id,
                          description: _product.description,
                          imageUrl: value,
                          isFavorite: _product.isFavorite,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(String text, TextInputType keyboardType) {
    return TextFormField(
      decoration: InputDecoration(labelText: text),
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      focusNode: _priceFocusNode,
    );
  }
}
