import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/providers/orders.dart';

import '/widgets/app_drawer.dart';
import '/widgets/order_items.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = 'order-screem';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Orders>(context, listen: false).fitchOrders().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () {
                return Provider.of<Orders>(context, listen: false)
                    .fitchOrders();
              },
              child: ListView.builder(
                itemBuilder: ((context, index) =>
                    OrderItems(order: orderData.orders[index])),
                itemCount: orderData.orders.length,
              ),
            ),
    );
  }
}
