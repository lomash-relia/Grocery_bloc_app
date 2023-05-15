part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

//states to build ui use HomeState
class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

//states to take some action use HomeActionState which extends HomeState
abstract class HomeActionState extends HomeState {}

class HomeNavigateToWishlistPageActionState extends HomeActionState {}

class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomeProductItemAddedToWishlistActionState extends HomeActionState {}

class HomeProductItemAddedToCartActionState extends HomeActionState {}
