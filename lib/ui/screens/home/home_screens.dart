/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:flutter/material.dart';
import 'package:tr_store/domain/models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cartItemCount = 0;

  void _addToCart() {
    setState(() {
      _cartItemCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white,),
                onPressed: () {
                  // Navigate to the cart page
                },
              ),
              Visibility(
                visible: _cartItemCount > 0,
                child: Positioned(
                  right: 2,
                  top: 2,
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 16,
                      child: Text(
                        '$_cartItemCount',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: dummyProducts.length,
          itemBuilder: (context, index) {
            Product product = dummyProducts[index];
            return ProductItem(
                name: product.title ?? "",
                description: product.content ?? "",
                price: (product.userId ?? -1).toDouble(),
                thumbnailUrl: product.thumbnail ?? "",
                onAddToCart: _addToCart);
          }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String thumbnailUrl;
  final VoidCallback onAddToCart;

  const ProductItem({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnailUrl,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                thumbnailUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Price
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Add to cart button
            ElevatedButton(
              onPressed: onAddToCart,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Icon(Icons.shopping_cart, color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
