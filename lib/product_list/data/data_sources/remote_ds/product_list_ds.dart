import '../../models/ProductModel.dart';

abstract class ProductRemoteDS {
  Future<ProductModel> getProducts();
}
