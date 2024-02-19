/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 19/2/2024
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/ui/app_widgets/app_snack_bar.dart';
import 'package:tr_store/ui/app_widgets/custom_app_bar.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/ui/screens/bloc/product_cart_bloc.dart';
import 'package:tr_store/utils/app_constants.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Product? _product;

  void _addToCart(Product product) {
    context.read<ProductCartBloc>().add(AddProductToCart(product: product));
  }

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as Dot.
    _product = ModalRoute.of(context)!.settings.arguments as Product;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: _product?.title ?? AppString.productDetails,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RoutePath.cart);
                  },
                ),
                BlocBuilder<ProductCartBloc, ProductCartState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.cartsWithProducts?.isNotEmpty ?? false,
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
                              '${state.cartsWithProducts?.length}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        body: BlocConsumer<ProductCartBloc, ProductCartState>(
          listener: (context, state) {
            debugPrint("$ProductDetailsScreen: ProductCartState: $state");
            if (state.productCartStatus == ProductCartStatus.addToCartFailed) {
              // AppSnackBar.show(
              //     context: context,
              //     message: AppString.addToCartSuccessFailed,
              //     color: Colors.redAccent);
              AppSnackBar.show(
                  context: context,
                  message: AppString.itSeemsAlreadyAddedToCart,
                  color: Colors.blueAccent.withOpacity(0.7));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: CachedNetworkImage(
                              imageUrl: _product?.thumbnail ?? "",
                              width: double.infinity,
                              height: 200,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Name
                          Text(
                            _product?.title ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Description
                          Text(
                            _product?.content ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            text: TextSpan(
                                style: const TextStyle(fontSize: 16),
                                children: [
                              const TextSpan(
                                  text: "${AppString.price}: ",
                                  style: TextStyle(color: Colors.grey)),
                              TextSpan(
                                  text: "\$${_product!.userId}",
                                  style: const TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ])),
                        ElevatedButton(
                          onPressed: () {
                            if (_product != null) {
                              _addToCart(_product!);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                AppString.addToCart,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
