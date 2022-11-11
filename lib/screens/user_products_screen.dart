import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/user_product_item.dart';

import '/providers/products_provider.dart';

import '/widgets/app_drawer.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({super.key});

  static const routeName = "user-products-screen";

  Future<void> _refreshProducts(context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    print("object");
    //final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your products"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: (() {
                Navigator.of(context).pushNamed(EditProductScreen.roteName);
              }),
            )
          ],
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
            future: _refreshProducts(context),
            builder: (context, snapshot) {
              return snapshot.connectionState != ConnectionState.done
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () => _refreshProducts(context),
                      child: Consumer<ProductsProvider>(
                        builder: (context, productData, child) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemBuilder: (context, index) => UserProductItems(
                                title: productData.items[index].title,
                                imgUrl: productData.items[index].imageUrl,
                                id: productData.items[index].id,
                              ),
                              itemCount: productData.items.length,
                            ),
                          );
                        },
                      ));
            }));
  }
}
