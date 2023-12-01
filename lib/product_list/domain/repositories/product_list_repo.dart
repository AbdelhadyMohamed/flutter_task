import '../../data/models/ProductModel.dart';

abstract class ProductListRepo {
  Future<ProductModel> getProductList();
}
