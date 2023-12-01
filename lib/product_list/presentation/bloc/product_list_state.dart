part of 'product_list_bloc.dart';

enum ScreenStatus {
  init,
  loading,
  successfully,
  failures,
}

class ProductListState {
  final ScreenStatus? screenStatus;
  final ProductModel? productModel;

  bool? isFav;
  List<String>? iDs;

  ProductListState(
      {this.screenStatus, this.productModel, this.isFav, this.iDs});

  ProductListState copyWith(
      {ScreenStatus? screenStatus,
      ProductModel? productModel,
      bool? isFav,
      List<String>? iDs}) {
    return ProductListState(
      screenStatus: screenStatus ?? this.screenStatus,
      productModel: productModel ?? this.productModel,
      isFav: isFav,
      iDs: iDs ?? this.iDs,
    );
  }
}

class ProductListInitial extends ProductListState {
  ProductListInitial() : super(screenStatus: ScreenStatus.init);
}
