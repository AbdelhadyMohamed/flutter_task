import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../data/models/ProductModel.dart';

import '../../domain/use_cases/product_list_use_case.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

@injectable
class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  static ProductListBloc get(context) => BlocProvider.of(context);
  ProductListUseCase productListUseCase;
  static List<String>? iDs = [];
  ProductListBloc(this.productListUseCase) : super(ProductListInitial()) {
    on<ProductListEvent>((event, emit) async {
      emit(state.copyWith(screenStatus: ScreenStatus.loading));
      if (event is GetAllProducts) {
        var res = await productListUseCase.call();

        emit(state.copyWith(
            screenStatus: ScreenStatus.successfully, productModel: res));
      } else if (event is ChangeFavIcon) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.successfully, isFav: (event.isFave)));
      } else if (event is SearchEvent) {
        var res = await productListUseCase.call();
        ProductModel newProductModel = ProductModel();
        List<Products> result = [];
        for (int i = 0; i < res.products!.length; i++) {
          String? title = res.products?[i].title;
          if (title != null &&
              title.toLowerCase().contains(event.keyword.toLowerCase()) ==
                  true) {
            result.add(res.products![i]);
          }
          // for (int i = 0; i < result.length; i++) {
          //   print(result[i].title);
          // }
        }
        newProductModel.products = result;
        emit(state.copyWith(
            screenStatus: ScreenStatus.successfully,
            productModel: newProductModel));
      }
    });
  }
}
