/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/domain/models/cart_with_product.dart';
import 'package:tr_store/ui/app_widgets/custom_app_bar.dart';
import 'package:tr_store/ui/app_widgets/error_message.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/utils/app_constants.dart';

import 'bloc/product_bloc.dart';
import 'bloc/product_cart_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CartWithProduct> _cartsWithProducts = [];

  void _addToCart(Product product) {
    context
        .read<ProductCartBloc>()
        .add(AddProductToCartRequest(product: product));
    // context
    //     .read<ProductBloc>()
    //     .add(FetchProductsFromRemote());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: widget.title,
          showBackButton: false,
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
                    switch (state.uiStatus) {
                      case ProductCartStatus.fetchCartsWithProductsSuccess:
                        _cartsWithProducts = state.cartsWithProducts;
                        debugPrint(
                            "case fetchCartsWithProductsSuccess: ${_cartsWithProducts.length}");

                        return _cartsWithProducts.isNotEmpty
                            ? Positioned(
                                right: 2,
                                top: 2,
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 16,
                                    child: Text(
                                      '${_cartsWithProducts.length}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox();
                      default:
                        debugPrint("case default: ProductCartState: $state");
                        return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            switch (state.uiStatus) {
              case ProductStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ProductStatus.success:
                return state.products.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          Product? product = state.products[index];
                          bool isAlreadyAdded = false;

                          for (CartWithProduct cartWithProduct
                              in _cartsWithProducts) {
                            isAlreadyAdded =
                                cartWithProduct.product.id == product.id;
                          }

                          return ProductItem(
                              name: product.title,
                              description: product.content,
                              price: (product.userId).toDouble(),
                              thumbnailUrl: product.thumbnail,
                              onAddToCart: !isAlreadyAdded
                                  ? () => _addToCart(product)
                                  : null);
                        })
                    : const MessageView(message: AppString.dataNotFound);
              case ProductStatus.failed:
                return const ErrorMessageView(
                    message: AppString.failedToLoadData);
            }
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String thumbnailUrl;
  final Function()? onAddToCart;

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
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                width: 80,
                height: 80,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.redAccent,
                ),
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
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
