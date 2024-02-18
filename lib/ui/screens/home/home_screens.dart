/*
 * Copyright (c) 2024.
 * Created by: Abdullah Al Masud
 * Created on: 16/2/2024
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tr_store/data/db/app_database.dart';
import 'package:tr_store/data/di/app_component.dart';
import 'package:tr_store/ui/app_widgets/custom_app_bar.dart';
import 'package:tr_store/ui/app_widgets/error_message.dart';
import 'package:tr_store/ui/routes/route_path.dart';
import 'package:tr_store/utils/app_constants.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cartItemCount = 0;
  final _homeBloc = getIt<HomeBloc>();

  void _addToCart() {
    setState(() {
      _cartItemCount++;
    });
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            switch (state.uiStatus) {
              case HomeUiStatus.loading:
                return const Center(child: CircularProgressIndicator(),);
              case HomeUiStatus.success:
                return ((state.products?.length ?? 0) > 0)
                    ? ListView.builder(
                        itemCount: state.products?.length ?? 0,
                        itemBuilder: (context, index) {
                          Product? product = state.products?[index];
                          return ProductItem(
                              name: product?.title ?? "",
                              description: product?.content ?? "",
                              price: (product?.userId ?? 0).toDouble(),
                              thumbnailUrl: product?.thumbnail ?? "",
                              onAddToCart: _addToCart);
                        })
                    : const MessageView(message: AppString.dataNotFound);
              case HomeUiStatus.failed:
                return const ErrorMessageView(message: AppString.failedToLoadData);
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
              // child: Image.network(
              //   thumbnailUrl,
              //   width: 80,
              //   height: 80,
              //   fit: BoxFit.cover,
              // ),
              child: CachedNetworkImage(
                imageUrl: thumbnailUrl,
                width: 80,
                height: 80,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
