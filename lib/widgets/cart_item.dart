// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/providers/cart.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.title,
      required this.quantity,
      required this.price,
      required this.id,
      required this.productId});
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String id;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content:
                  const Text("Do you want to remove the item frem the cart?"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text("No")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: const Text("Yes"))
              ],
            );
          },
        );
      },
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: ((_) {
        cart.removeItem(productId);
      }),
      background: Container(
        child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            color: Theme.of(context).errorColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 26,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: FittedBox(
                  child: Text(
                "${(price).toStringAsFixed(2)} ",
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
          title: Text(title),
          subtitle: Text("Total: ${(price * quantity).toStringAsFixed(2)}"),
          trailing: Container(
            width: 100,
            child: Row(
              children: [
                Text("* $quantity"),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      quantity == 1
                          ? cart.removeItem(productId)
                          : cart.subtractItem(productId);
                    },
                    child: Icon(
                      Icons.exposure_minus_1,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
