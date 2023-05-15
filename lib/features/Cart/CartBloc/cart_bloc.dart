import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/data/cart_items.dart';
import 'package:bloc_example/features/Home/models/HomeProductDataModel.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveItemEvent>(cartRemoveItemEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItems));
  }

  FutureOr<void> cartRemoveItemEvent(
      CartRemoveItemEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.clickedProduct);
    emit(CartSuccessState(cartItems: cartItems));
  }
}
