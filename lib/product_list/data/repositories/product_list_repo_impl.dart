import 'package:injectable/injectable.dart';

import '../../domain/repositories/product_list_repo.dart';
import '../data_sources/remote_ds/product_list_ds.dart';
import '../models/ProductModel.dart';

@Injectable(as: ProductListRepo)
class ProductListRepoImpl implements ProductListRepo {
  ProductRemoteDS productRemoteDS;

  ProductListRepoImpl(this.productRemoteDS);

  @override
  Future<ProductModel> getProductList() => productRemoteDS.getProducts();
}
