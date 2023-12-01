part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class GetAllProducts extends ProductListEvent {}

class ChangeFavIcon extends ProductListEvent {
  final bool isFave;
  ChangeFavIcon(this.isFave);
}
