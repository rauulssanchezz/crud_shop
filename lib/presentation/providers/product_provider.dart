import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final FirebaseFirestore _db;

  ProductProvider({required FirebaseFirestore db}) : _db = db;

  String _errorMessage = 'Error en el servidor';
  bool productAdded = false;

  Future<QuerySnapshot<Map<String, dynamic>>> _findProduct({required String name}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot;
    
    querySnapshot = await _db
        .collection('products')
        .where('name', isEqualTo: name)
        .get();
    

    return querySnapshot;
  }

  Future<String> addProduct({
    required String name,
    required String description,
    required double price,
    required int stock,
    String? imageUrl,
  }) async {
    try {
      final querySnapshot = await _findProduct(name: name);

      if (querySnapshot.docs.isNotEmpty) {
        _errorMessage = 'El producto ya existe';
        throw ErrorHint(_errorMessage);
      }

      final docRef = _db.collection('products').doc();
      final String productId = docRef.id;

      Map<String, dynamic> productData = {
        'id': productId,
        'name': name,
        'description': description,
        'price': price,
        'stock': stock,
        if (imageUrl != null) 'imageUrl': imageUrl,
      };

      await docRef.set(productData);

      productAdded = true;
      notifyListeners();
    } catch(e) {
      throw ErrorHint(_errorMessage);
    }

    return 'Producto guardado correctamente';
  }

  void resetFlags() {
    productAdded = false;
    notifyListeners();
  }
}