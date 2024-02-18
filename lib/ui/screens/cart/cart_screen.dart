/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:flutter/material.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/ui/utils/app_strings.dart';
import 'package:tr_store/ui/utils/app_widgets/custom_app_bar.dart';

class CartScreen extends StatefulWidget {
  final List<Product> products;
  final List<Cart> carts;

  const CartScreen({super.key, required this.products, required this.carts});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppString.cart,
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: widget.carts.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  final cart = widget.carts[index];
                  final product =
                      widget.products.firstWhere((p) => p.id == cart.productId);

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            product.image,
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
                                product.title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Description
                              Text(
                                product.content,
                                style: const TextStyle(fontSize: 14),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // Price
                              Text(
                                '\$${product.userId} x ${cart.productQuantity} = ?',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(width: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  // if (cartItem.productQuantity > 1) {
                                  //   cartItem.productQuantity--;
                                  // }
                                });
                              },
                            ),
                            Text(cart.productQuantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                // setState(() {
                                //   cartItem.productQuantity++;
                                // });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  widget.carts.removeAt(index);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Card(
              margin: EdgeInsets.zero,
              shape: const Border(),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                        text:
                            const TextSpan(style: TextStyle(fontSize: 16), children: [
                      TextSpan(
                          text: "${AppString.total}: ",
                          style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: "?",
                          style: TextStyle(color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                    ])),
                    ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: const Text(
                        AppString.checkout,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
