import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/products_overview_screen.dart';

import '../providers/auth.dart';
import '../screens/cart_screen.dart';
import '/screens/user_products_screen.dart';
import '/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AppBar(
            title: const Text("Hello friend!"),
            automaticallyImplyLeading: false,
          ),
          // Divider(),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              Icons.shop,
              color: Colors.purple,
            ),
            title: const Text("Shop", style: TextStyle(color: Colors.purple)),
            onTap: () => Navigator.of(context)
                .pushNamed(ProductsOverviewScreen.routeName),
          ),
          ListTile(
            leading: const Icon(
              Icons.payment,
              color: Colors.purple,
            ),
            title: const Text("Orders", style: TextStyle(color: Colors.purple)),
            onTap: () => Navigator.of(context).pushNamed(OrderScreen.routeName),
          ),
          Expanded(
            child: ListTile(
              leading: const Icon(
                Icons.payment,
                color: Colors.purple,
              ),
              title: const Text(
                "Manage Products",
                style: TextStyle(color: Colors.purple),
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(UserProductsScreen.routeName),
            ),
          ),

          ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.purple,
                size: 26,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.purple),
              ),
              onTap: () async {
                await Provider.of<Auth>(context, listen: false).logout();
                Navigator.of(context)
                    .pushReplacementNamed(CartScreen.routeName);
              }),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
