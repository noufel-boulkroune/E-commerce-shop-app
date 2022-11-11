import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';
import 'package:shop_app/screens/animation_splash_screen.dart';
import '/providers/products_provider.dart';
import '/providers/orders.dart';
import 'providers/auth.dart';
import 'providers/cart.dart';

//import 'package:shop_app/providers/product.dart';
// import '/screens/auth_screen.dart';
import '/screens/edit_product_screen.dart';
// import '/screens/splash_screen.dart';
import '/screens/user_products_screen.dart';
import '/screens/cart_screen.dart';
import '/screens/orders_screen.dart';
import '/screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, ProductsProvider>(
            update: (context, auth, previousProducts) => ProductsProvider(
                auth.token as String,
                previousProducts == null ? [] : previousProducts.items,
                auth.userId as String),
            create: (context) => ProductsProvider("", [], ""),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, auth, previousOrders) => Orders(
                auth.token as String,
                previousOrders == null ? [] : previousOrders.orders,
                auth.userId as String),
            create: (context) => Orders("", [], ""),
          )
        ],
        child: Consumer<Auth>(builder: (context, value, child) {
          return MaterialApp(
            title: 'My Shop',
            theme: ThemeData(
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder()
              }),
              primarySwatch: MaterialColor(
                0xffCE28AD, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
                const <int, Color>{
                  50: const Color(0xffb9249c), //10%
                  100: const Color(0xffa5208a), //20%
                  200: const Color(0xff901c79), //30%
                  300: const Color(0xff7c1868), //40%
                  400: const Color(0xff671457), //50%
                  500: const Color(0xff521045), //60%
                  600: const Color(0xff3e0c34), //70%
                  700: const Color(0xff290823), //80%
                  800: const Color(0xff150411), //90%
                  900: const Color(0xff000000), //100%
                },
              ),
              accentColor: Colors.deepOrange,
              fontFamily: "Lato",
              //canvasColor: Colors.amber
            ),

            //home: ProductsOverviewScreen(),
            home: AnimationSplashScreen(),
            // Provider.of<Auth>(context, listen: false).isAuth
            //     ? ProductsOverviewScreen()
            //     : FutureBuilder(
            //         future: Provider.of<Auth>(context, listen: false)
            //             .tryAutoLogin(),
            //         builder: (context, snapshot) {
            //           if (snapshot.connectionState == ConnectionState.waiting) {
            //             return SplashScreen();
            //           } else {
            //             return AuthScreen();
            //           }
            //         },
            //       ),
            routes: {
              ProductsOverviewScreen.routeName: (context) =>
                  ProductsOverviewScreen(),
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrderScreen.routeName: (context) => const OrderScreen(),
              UserProductsScreen.routeName: (context) =>
                  const UserProductsScreen(),
              EditProductScreen.roteName: (context) => EditProductScreen(),
            },
          );
        }));
  }
}
