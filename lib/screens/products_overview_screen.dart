import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import '/providers/cart.dart';

import '/screens/cart_screen.dart';

import '/widgets/app_drawer.dart';
import '/widgets/badge.dart';
import '/widgets/product_gridview.dart';

enum FilterOptions {
  Favorits,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({super.key});

  static const routeName = "product-overniew-screen";

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isFavoritSelected = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((value) => null);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductsProvider>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  // ProductsOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text("Products list"),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == FilterOptions.Favorits) {
                    _isFavoritSelected = true;
                  } else {
                    _isFavoritSelected = false;
                  }
                });
              },
              itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(
                      value: FilterOptions.Favorits,
                      child: Text('Favorits'),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.All,
                      child: Text('All'),
                    ),
                  ]),
          Consumer<Cart>(
            child: IconButton(
              onPressed: (() {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }),
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (BuildContext context, cart, Widget? child) {
              return Badge(
                value: cart.itemCount.toString(),
                child: child as Widget,
              );
            },
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductGridView(
              showFav: _isFavoritSelected,
            ),
    );
  }
}
