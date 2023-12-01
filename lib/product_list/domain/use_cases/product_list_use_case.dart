import 'package:injectable/injectable.dart';

import '../../data/models/ProductModel.dart';
import '../repositories/product_list_repo.dart';

@injectable
class ProductListUseCase {
  ProductListRepo productListRepo;

  ProductListUseCase(this.productListRepo);
  Future<ProductModel> call() => productListRepo.getProductList();
}
