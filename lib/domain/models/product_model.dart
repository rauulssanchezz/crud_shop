class ProductModel {
  final String _id;
  String _name;
  String _description;
  double _price;
  int _stock;
  bool _hasChanges = false;

  ProductModel({
    required String name,
    required String description,
    required double price,
    required int stock,
    required String id
  }):
    _name = name,
    _description = description,
    _price = price,
    _stock = stock,
    _id = id;

  get getName => _name;
  get getDescription => _description;
  get getPrice => _price;
  get getStock => _stock;
  get getId => _id;
  get getHasChanges => _hasChanges;

  set setName(String name) {
    if (name != _name) {
      _name = name;
      _hasChanges = true;
    }
  }

  set setDescription(String description) {
    if (description != _description) {
      _description = description;
      _hasChanges = true;
    }
  }

  set setPrice(double price) {
    if (price != _price && price >= 0.0) {
      _price = price;
      _hasChanges = true;
    }
  }

  set setStock(int stock) {
    if (stock != _stock && stock >= 0) {
      _stock = stock;
      _hasChanges = true;
    }
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0.0,
      stock: map['stock'] ?? 0,
      id: map['id']
    );
  }
}