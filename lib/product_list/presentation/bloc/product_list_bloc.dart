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
        var res= await productListUseCase.call();

          emit(state.copyWith(
              screenStatus: ScreenStatus.successfully, productModel: res));

      } else if (event is ChangeFavIcon) {
        emit(state.copyWith(
            screenStatus: ScreenStatus.successfully, isFav: (event.isFave)));
      }
    });
  }
}
