import 'dart:convert';

import 'package:crud/models/product.dart';
import 'package:crud/ui/screens/add_new_product_screen.dart';
import 'package:crud/ui/widget/product_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];

  bool _getProductListInProgress = false;

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product List',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _getProductList();
            },
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _getProductList();
        },
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductItem(
                product: productList[index], delete: () {_deleteProductItem(productList[index].id!);  },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }

  Future<void> _getProductList() async {
    productList.clear();
    _getProductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      print(decodedData['status']);
      for (Map<String, dynamic> p in decodedData['data']) {
        Product product = Product(
          id: p['_id'],
          productName: p['ProductName'],
          productCode: p['ProductCode'],
          image: p['Img'],
          price: p['UnitPrice'],
          quantity: p['Qty'],
          totalPrice: p['TotalPrice'],
          createdDate: p['CreatedDate'],
        );
        productList.add(product);
      }
      setState(() {});
    }
    _getProductListInProgress = false;
    setState(() {});
  }

  Future<void> _productDelete(String id) async {
    Uri uri =
        Uri.parse('https://crud.teamrabbil.com/api/v1/DeleteProduct/${id}');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _getProductList();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delete Success'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delete Processing'),
        ),
      );
      setState(() {});
    }
  }

  void _deleteProductItem(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product!'),
          content: const Text('Are you sure ?'),
          actions: [
            TextButton(
              onPressed: () {
                _productDelete(id);
                Navigator.pop(context);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
