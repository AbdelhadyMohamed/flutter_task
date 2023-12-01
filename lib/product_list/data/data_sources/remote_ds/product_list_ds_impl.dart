import 'package:dio/dio.dart';
import 'package:flutter_task/product_list/data/data_sources/remote_ds/product_list_ds.dart';
import 'package:injectable/injectable.dart';

import '../../../../shared/api_manager.dart';
import '../../models/ProductModel.dart';

@Injectable(as: ProductRemoteDS)
class ProductRemoteDSImpl implements ProductRemoteDS {
  ApiManager apiManager;
  ProductRemoteDSImpl(this.apiManager);

  @override
  Future<ProductModel> getProducts() async {
    try {
      Response response = await apiManager.getData();
      ProductModel productModel = ProductModel.fromJson(response.data);
      // print(productModel.results ?? "no results");

      return productModel;
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }
}
