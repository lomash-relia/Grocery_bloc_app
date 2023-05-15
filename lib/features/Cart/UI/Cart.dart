import 'package:bloc_example/features/Cart/CartBloc/cart_bloc.dart';
import 'package:bloc_example/features/Cart/UI/CartTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                  itemCount: successState.cartItems.length,
                  itemBuilder: (context, index) {
                    return CartTile(
                      productDataModel: successState.cartItems[index],
                      cartBloc: cartBloc,
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
