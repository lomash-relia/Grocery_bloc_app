import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_example/data/cart_items.dart';
import 'package:bloc_example/data/grocery_data.dart';
import 'package:bloc_example/data/wishlist_items.dart';
import 'package:bloc_example/features/Home/models/HomeProductDataModel.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeWishlistButtonNavigateEvent>(homeWishlistNavigateEvent);

    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);

    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    print('Home Loading State');
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 4));
    emit(HomeLoadedSuccessState(
      products: GroceryData.groceryProducts
          .map((product) => ProductDataModel(
              id: product['id'],
              name: product['name'],
              unit: product['unit'],
              price: product['price'],
              imageURL: product['imageURL']!))
          .toList(),
    ));
  }

  FutureOr<void> homeWishlistNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('AppBar Wishlist Navigate clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    print('AppBar Cart Navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Product Wishlist Button Clicked');
    wishlistItems.add(event.clickedProduct);
    emit(HomeProductItemAddedToWishlistActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Product Cart Button Clicked');
    cartItems.add(event.clickedProduct);
    emit(HomeProductItemAddedToCartActionState());
  }
}
