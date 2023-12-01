part of 'product_list_bloc.dart';

@immutable
abstract class ProductListEvent {}

class GetAllProducts extends ProductListEvent {}

class SearchEvent extends ProductListEvent {
  String keyword;
  SearchEvent(this.keyword);
}

class ChangeFavIcon extends ProductListEvent {
  final bool isFave;
  ChangeFavIcon(this.isFave);
}
