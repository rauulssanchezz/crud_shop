import 'package:crud_shop/presentation/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final FocusNode _productName = FocusNode();
  final FocusNode _productPrice = FocusNode();
  final FocusNode _productDescription = FocusNode();
  final FocusNode _productStock = FocusNode();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _productStockController = TextEditingController();

  @override
  void dispose() {
    _productName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    CustomTextFormFieldWithHint(
                      controller: _productNameController, 
                      focusNode: _productName, 
                      labelText: 'Introduce el nombre del producto', 
                      isPassword: false,
                      topLabel: 'Nombre del producto',
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_productPrice),
                    ),
          
                    SizedBox(
                        height: 20.0,
                      ),
          
                    CustomTextFormFieldWithHint(
                      controller: _productPriceController, 
                      focusNode: _productPrice, 
                      labelText: 'Introduce el precio', 
                      isPassword: false,
                      topLabel: 'Precio',
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_productDescription),
                    ),
          
                    SizedBox(
                        height: 20.0,
                      ),
          
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
                            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(20))
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
          
                    SizedBox(
                        height: 20.0,
                      ),
          
                    CustomTextFormFieldWithHint(
                      controller: _productStockController, 
                      focusNode: _productStock, 
                      labelText: 'Introduce la cantidad disponible', 
                      isPassword: false,
                      topLabel: 'Stock',
                    ),
          
                    SizedBox(
                        height: 20.0,
                      ),
                
                      SizedBox(
                        width: double.infinity,
                        height: 50.0,
                        child: FilledButton(
                          onPressed: () async {
                            
                          },
                          child: const Text('Registrarse')
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        )
      ),
    );
  }
}