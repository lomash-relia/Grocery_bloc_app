import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/data/wishlist_items.dart';
import 'package:bloc_example/features/Home/models/HomeProductDataModel.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveItemEvent>(wishlistRemoveItemEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }

  FutureOr<void> wishlistRemoveItemEvent(
      WishlistRemoveItemEvent event, Emitter<WishlistState> emit) {
    wishlistItems.remove(event.clickedProduct);
    emit(WishlistSuccessState(wishlistItems: wishlistItems));
  }
}
