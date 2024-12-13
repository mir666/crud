import 'dart:convert';

import 'package:crud/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update-product';

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _upgrateProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _codeTEController.text = widget.product.productCode ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _priceTEController.text = widget.product.price ?? '';
    _totalPriceTEController.text = widget.product.totalPrice ?? '';
    _imageTEController.text = widget.product.image ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update product',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildProductForm(),
        ),
      ),
    );
  }

  // Form extract method
  Widget buildProductForm() {
    // TODO: complete form validation
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Product name';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Product Name',
              hintText: 'Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _codeTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Product code';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Product code',
              hintText: 'Code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _quantityTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Product quantity';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Product quantity',
              hintText: 'Quantity',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _priceTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Product price';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Product price',
              hintText: 'Price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _totalPriceTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Product total price';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Product total price',
              hintText: 'Total price',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _imageTEController,
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter Product image';
              }

              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: 'Product image url',
              hintText: 'Image url',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Visibility(
            visible: _upgrateProductInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateProduct();
                }
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                backgroundColor: Colors.cyan,
              ),
              child: const Text(
                'Update Product',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProduct() async {
    _upgrateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(
        'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');

    Map<String?, dynamic> responseBody = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _codeTEController.text.trim(),
      "ProductName": _nameTEController.text.trim(),
      "Qty": _quantityTEController.text.trim(),
      "TotalPrice": _totalPriceTEController.text.trim(),
      "UnitPrice": _priceTEController.text.trim()
    };

    Response response = await post(
      uri,
      headers: {'Content-type': 'Application/json'},
      body: jsonEncode(responseBody),
    );
    print(response.statusCode);
    print(response.body);
    _upgrateProductInProgress = false;
    setState(() {});
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Update Success!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Update Failed! Try again.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _codeTEController.dispose();
    _quantityTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
