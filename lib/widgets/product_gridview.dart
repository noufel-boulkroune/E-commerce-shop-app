import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '/providers/products_provider.dart';
import '/providers/product.dart';

import 'product_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.showFav,
  });
  final bool showFav;

  // const ProductGridView({
  //   Key? key,
  //   required this.loadedProducts,
  // }) : super(key: key);

  // final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    List<Product> product =
        showFav == true ? productsData.favoritItems : productsData.items;
    return AnimationLimiter(
      child: GridView.builder(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: Duration(milliseconds: 500),
            columnCount: 2,
            child: ScaleAnimation(
              duration: Duration(milliseconds: 900),
              curve: Curves.fastLinearToSlowEaseIn,
              child: FadeInAnimation(
                child: ChangeNotifierProvider.value(
                  value: product[index],
                  child: const ProductItem(
                      // imageUrl: products[index].imageUrl,
                      // id: products[index].id,
                      // title: products[index].title,
                      ),
                ),
              ),
            ),
          );
        },
        itemCount: product.length,
      ),
    );
  }
}
