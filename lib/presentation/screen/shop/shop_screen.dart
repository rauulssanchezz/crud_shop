import 'package:crud_shop/domain/models/product_model.dart';
import 'package:crud_shop/presentation/providers/product_provider.dart';
import 'package:crud_shop/presentation/widgets/product/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda'),
        centerTitle: true, 
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: productProvider.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            final productList = snapshot.data!;
            return ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Product(
                  name: product.getName,
                  description: product.getDescription,
                  price: product.getPrice,
                  stock: product.getStock,
                );
              },
            );
          }
        },
      ),
    );
  }
}