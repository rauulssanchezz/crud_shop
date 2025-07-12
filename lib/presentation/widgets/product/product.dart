import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final int stock;

  const Product({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.stock
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: Column(
          children: [
            Card.filled(
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _CustomText(name: name),
                        IconButton(
                          onPressed: () {}, 
                          icon: Icon(
                            Icons.add_shopping_cart_outlined,
                            color: Color.fromRGBO(242, 130, 33, 1),
                            )
                        )
                      ],
                    ),
                    _CustomText(name: description),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _CustomText(name: 'Precio: $price'),
                        _CustomText(name: 'Cantidad disponible $stock')
                      ],
                    )
                  ],
                ),
              )
            )
          ],
        ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(name),
    );
  }
}