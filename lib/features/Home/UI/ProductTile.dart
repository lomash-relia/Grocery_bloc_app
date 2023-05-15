import 'package:bloc_example/features/Home/HomeBloc/home_bloc.dart';
import 'package:bloc_example/features/Home/models/HomeProductDataModel.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(
      {Key? key, required this.productDataModel, required this.homeBloc})
      : super(key: key);

  final HomeBloc homeBloc;

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
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickedEvent(
                            clickedProduct: productDataModel));
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel));
                    },
                    icon: const Icon(
                      Icons.add_shopping_cart_outlined,
                      //     color: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
