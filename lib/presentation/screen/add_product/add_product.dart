import 'package:crud_shop/presentation/providers/product_provider.dart';
import 'package:crud_shop/presentation/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ref = FirebaseStorage.instance.ref().child('product_images/$fileName');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
  final FocusNode _productName = FocusNode();
  final FocusNode _productPrice = FocusNode();
  final FocusNode _productDescription = FocusNode();
  final FocusNode _productStock = FocusNode();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _productName.dispose();
    _productDescription.dispose();
    _productPrice.dispose();
    _productStock.dispose();

    _productNameController.dispose();
    _productDescriptionController.dispose();
    _productPriceController.dispose();
    _productStockController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.read<ProductProvider>();
    final bool productAdded = context.watch<ProductProvider>().productAdded;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (productAdded) {
        setState(() => _isLoading = false);
        productProvider.resetFlags();
      }
    });

    void validateInputs() {
      if (
        _productNameController.text == ''
        || _productDescriptionController.text == ''
        || _productPriceController.text == ''
        || _productStockController.text == ''
      ) 
      {
        throw ErrorHint('Todos los campos son obligatorios');
      }

      try {
        double price = double.parse(_productPriceController.text);
        int stock = int.parse(_productStockController.text);

        if (price < 0.0 || stock < 0) {
          throw ErrorHint('El precio y el stock no pueden ser menos de 0');
        }
      } on FormatException {
        throw ErrorHint('El precio y el stock deben ser números válidos');
      }
    }

    void clearControllers() {
      _productNameController.text = '';
      _productDescriptionController.text = '';
      _productPriceController.text = '';
      _productStockController.text = '';
    }

    void addProducts() async {
      try {
        setState(() => _isLoading = true);
        validateInputs();

        String productName = _productNameController.text;
        String productDescription = _productDescriptionController.text;
        double productPrice = double.parse(_productPriceController.text);
        int productStock = int.parse(_productStockController.text);

        String? imageUrl;
        if (_selectedImage != null) {
          imageUrl = await _uploadImage(_selectedImage!);
          if (imageUrl == null) {
            throw ErrorHint('Error al subir la imagen');
          }
        }

        clearControllers();
        setState(() {
          _selectedImage = null;
        });

        String success = await productProvider.addProduct(
          name: productName,
          description: productDescription,
          price: productPrice,
          stock: productStock,
          imageUrl: imageUrl,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir producto'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Form(
                child: Column(
                  children: [
                    // Imagen
                    GestureDetector(
                      onTap: _pickImage,
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                _selectedImage!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: const Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                            ),
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormFieldWithHint(
                      controller: _productNameController,
                      focusNode: _productName,
                      labelText: 'Introduce el nombre del producto',
                      isPassword: false,
                      topLabel: 'Nombre del producto',
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_productPrice),
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormFieldWithHint(
                      controller: _productPriceController,
                      focusNode: _productPrice,
                      labelText: 'Introduce el precio',
                      isPassword: false,
                      topLabel: 'Precio',
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_productDescription),
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Descripción',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextFormField(
                          maxLines: 5,
                          controller: _productDescriptionController,
                          focusNode: _productDescription,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Introduce una descripción',
                            labelStyle: TextStyle(
                              color: Color.fromRGBO(156, 112, 74, 1),
                            ),
                            filled: true,
                            fillColor: Color.fromRGBO(245, 237, 232, 1),
                            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20)),
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_productStock),
                          onTapOutside: (event) {
                            _productDescription.unfocus();
                          },
                          obscureText: false,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    CustomTextFormFieldWithHint(
                      controller: _productStockController,
                      focusNode: _productStock,
                      labelText: 'Introduce la cantidad disponible',
                      isPassword: false,
                      topLabel: 'Stock',
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: FilledButton(
                        onPressed: addProducts,
                        child: const Text('Registrarse'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}