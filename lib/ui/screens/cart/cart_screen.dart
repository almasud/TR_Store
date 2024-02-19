/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 18/2/2024
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/domain/models/cart_with_product.dart';
import 'package:tr_store/ui/app_widgets/app_snack_bar.dart';
import 'package:tr_store/ui/app_widgets/custom_app_bar.dart';
import 'package:tr_store/ui/app_widgets/error_message.dart';
import 'package:tr_store/ui/screens/bloc/product_cart_bloc.dart';
import 'package:tr_store/utils/app_constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

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
        body: BlocBuilder<ProductCartBloc, ProductCartState>(
          builder: (context, state) {
            List<CartWithProduct>? cartsWithProducts = state.cartsWithProducts;

            return (cartsWithProducts?.isNotEmpty ?? false)
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: cartsWithProducts?.length ?? 0,
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider();
                          },
                          itemBuilder: (context, index) {
                            final cart = cartsWithProducts![index].cart;
                            final product = cartsWithProducts
                                .map((e) => e.product)
                                .firstWhere((p) => p.id == cart.productId);

                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Thumbnail
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: CachedNetworkImage(
                                      imageUrl: product.image,
                                      width: 80,
                                      height: 80,
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          '\$${product.userId} x ${cart.productQuantity} = \$${product.userId * cart.productQuantity}',
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
                                          if (cart.productQuantity > 1) {
                                            context.read<ProductCartBloc>().add(
                                                UpdateProductQuantityToCart(
                                                    productId: product.id,
                                                    newProductQuantity:
                                                        cart.productQuantity -
                                                            1));
                                          }
                                        },
                                      ),
                                      Text(cart.productQuantity.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          context.read<ProductCartBloc>().add(
                                              UpdateProductQuantityToCart(
                                                  productId: product.id,
                                                  newProductQuantity:
                                                      cart.productQuantity +
                                                          1));
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          context.read<ProductCartBloc>().add(
                                              DeleteProductsFromCart(
                                                  cartId: cart.id));
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
                      Visibility(
                        visible: cartsWithProducts?.isNotEmpty ?? false,
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: const Border(),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // RichText(
                                //     text: const TextSpan(
                                //         style: TextStyle(fontSize: 16),
                                //         children: [
                                //       TextSpan(
                                //           text: "${AppString.total}: ",
                                //           style: TextStyle(color: Colors.grey)),
                                //       TextSpan(
                                //           text: "?",
                                //           style: TextStyle(
                                //               color: Colors.redAccent,
                                //               fontSize: 18,
                                //               fontWeight: FontWeight.bold)),
                                //     ])),
                                ElevatedButton(
                                  onPressed: () {
                                    AppSnackBar.show(
                                        context: context,
                                        message:
                                            AppString.thisFeatureIsComingSoon,
                                        color:
                                            Colors.blueAccent.withOpacity(0.7));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                  ),
                                  child: const Text(
                                    AppString.checkout,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : const MessageView(message: AppString.noDataFound);
          },
        ),
      ),
    );
  }
}
