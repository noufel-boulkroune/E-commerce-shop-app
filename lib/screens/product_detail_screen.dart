import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const routeName = "product-detail";

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    //  Provider.of<ProductsProvider>(context)
    //     .items
    //     .firstWhere((product) => productId == product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                      BorderSide(width: 1, color: Colors.black45))),
              margin: const EdgeInsets.only(bottom: 10),
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "${loadedProduct.price.toString()} \$",
              style: const TextStyle(color: Colors.pink, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 30),
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.6),
                  //  border: Border.all(),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                loadedProduct.description,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
              ),
            )
          ],
        ),
      ),
      // ChangeNotifierProvider.value(
      //       value: loadedProduct, child: const ProductItem()),
    );
  }
}
