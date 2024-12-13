import 'package:crud/models/product.dart';
import 'package:crud/ui/screens/add_new_product_screen.dart';
import 'package:crud/ui/screens/product_list_screen.dart';
import 'package:crud/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings setting) {
        late Widget widget;
        if (setting.name == '/') {
          widget = const ProductListScreen();
        } else if (setting.name == AddNewProductScreen.name) {
          widget = const AddNewProductScreen();
        } else if (setting.name == UpdateProductScreen.name) {
          final Product product = setting.arguments as Product;
          widget = UpdateProductScreen(
            product: product,
          );
        }
        return MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        );
      },
    );
  }
}
