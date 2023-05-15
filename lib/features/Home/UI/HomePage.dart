import 'package:bloc_example/features/Cart/UI/Cart.dart';
import 'package:bloc_example/features/Home/HomeBloc/home_bloc.dart';
import 'package:bloc_example/features/Home/UI/ProductTile.dart';
import 'package:bloc_example/features/Wishlist/UI/WishList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductItemAddedToWishlistActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Added to Wishlist')));
        } else if (state is HomeProductItemAddedToCartActionState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Item Added to Cart')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Grocery App'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishlistButtonNavigateEvent());
                        },
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined),
                    ),
                  ],
                ),
                body: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        productDataModel: successState.products[index],
                        homeBloc: homeBloc,
                      );
                    }));
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text(
                  'ERROR',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            );
          default:
            return const Center(
              child: Text(
                'Default',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            );
        }
      },
    );
  }
}
