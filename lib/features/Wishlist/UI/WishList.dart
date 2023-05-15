import 'package:bloc_example/features/Wishlist/UI/WishlistTile.dart';
import 'package:bloc_example/features/Wishlist/WishlistBloc/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({Key? key}) : super(key: key);

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    super.initState();
    wishlistBloc.add(WishlistInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return ListView.builder(
                  itemCount: successState.wishlistItems.length,
                  itemBuilder: (context, index) {
                    return WishlistTile(
                      productDataModel: successState.wishlistItems[index],
                      wishlistBloc: wishlistBloc,
                    );
                  });
            default:
              return const Center(
                child: Text(
                  'Default',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              );
          }
        },
      ),
    );
  }
}
