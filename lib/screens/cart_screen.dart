import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../providers/cart.dart' as cr;

import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = 'cart-Screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<cr.Cart>(context);
    final order = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      "\$${cart.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  orderButton(cart: cart, order: order),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => CartItem(
              price: cart.items.values.toList()[index].price,
              quantity: cart.items.values.toList()[index].quantity,
              id: cart.items.values.toList()[index].id,
              title: cart.items.values.toList()[index].title,
              productId: cart.items.keys.toList()[index],
            ),
            itemCount: cart.itemCount,
          ))
        ],
      ),
    );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key? key,
    required this.cart,
    required this.order,
  }) : super(key: key);

  final cr.Cart cart;
  final Orders order;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (widget.cart.totalPrice <= 0) || (_isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });

                await widget.order
                    .addOrder(widget.cart.items.values.toList(),
                        widget.cart.totalPrice)
                    .then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                });
                widget.cart.clear();
              },
        child:
            _isLoading ? CircularProgressIndicator() : const Text("ORDER NOW"));
  }
}
