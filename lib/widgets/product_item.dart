// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';

import '/providers/product.dart';
import '/providers/cart.dart';

import '/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  // const ProductItem(
  //     {super.key,
  //     required this.imageUrl,
  //     required this.id,
  //     required this.title});
  // final String imageUrl;
  // final String id;
  // final String title;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return GridTile(
      child: GestureDetector(
        onTap: (() {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        }),
        child: FadeInImage(
          placeholder: AssetImage("assets/images/product-placeholder.png"),
          image: NetworkImage(
            product.imageUrl,
          ),
          fit: BoxFit.contain,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: Consumer<Product>(
          builder: (BuildContext context, product, Widget? child) {
            Text("Never Change!");
            return IconButton(
              //label:child,  child never rebuild
              onPressed: (() {
                product.toogleFavorite(
                    auth.userId as String, auth.token as String);
              }),
              icon: product.isFavorite
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              color: Colors.pink,
            );
          },
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          onPressed: (() {
            cart.addItem(product.id, product.title, product.price);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              content: Text("Added item to card!"),
              duration: Duration(seconds: 2),
              action: SnackBarAction(
                label: "Undo ",
                textColor: Theme.of(context).primaryColorDark,
                onPressed: () {
                  cart.removeSingleItem(product.id);
                },
              ),
            ));
          }),
          icon: const Icon(Icons.shopping_cart),
          color: Colors.pink,
        ),
      ),
    );
  }
}
