import 'package:crud/models/product.dart';
import 'package:crud/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product, required this.delete});

  final Product product;
  final VoidCallback delete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image ?? '',
        width: 40,
      ),
      title: Text(
        product.productName ?? '',
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'product code: ${product.productCode ?? ''}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'product price: ${product.price ?? ''}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'product quantity: ${product.quantity ?? ''}',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            'product total price: ${product.totalPrice ?? ''}',
          ),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: delete,
            icon: const Icon(
              Icons.delete,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                UpdateProductScreen.name,
                arguments: product,
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
    );
  }


}
