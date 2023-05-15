import 'package:bloc_example/features/Cart/CartBloc/cart_bloc.dart';
import 'package:bloc_example/features/Home/models/HomeProductDataModel.dart';
import 'package:bloc_example/features/Wishlist/WishlistBloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';

class WishlistTile extends StatelessWidget {
  const WishlistTile(
      {Key? key, required this.productDataModel, required this.wishlistBloc})
      : super(key: key);

  final WishlistBloc wishlistBloc;

  final ProductDataModel productDataModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            productDataModel.imageURL,
          ),
          const SizedBox(
            height: 10,
            width: double.maxFinite,
          ),
          Text(
            productDataModel.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
            width: double.maxFinite,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "\$ ${productDataModel.price} per ${productDataModel.unit}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: () {
                  wishlistBloc.add(WishlistRemoveItemEvent(
                      clickedProduct: productDataModel));
                },
                icon: const Icon(
                  Icons.highlight_remove,
                  //     color: Colors.green,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
