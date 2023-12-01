import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/product_list/data/data_sources/remote_ds/product_list_ds_impl.dart';
import 'package:flutter_task/product_list/data/repositories/product_list_repo_impl.dart';
import 'package:flutter_task/product_list/domain/use_cases/product_list_use_case.dart';
import 'package:flutter_task/shared/api_manager.dart';
import '../../../config.dart';
import '../bloc/product_list_bloc.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListBloc(ProductListUseCase(
          ProductListRepoImpl(ProductRemoteDSImpl(ApiManager()))))
        ..add(GetAllProducts()),
      child: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          bool fav = false;
          return Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 65.h,
                        child: SearchBar(
                          padding: MaterialStatePropertyAll<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h)),
                          onChanged: (value) {
                            ProductListBloc.get(context)
                                .add(SearchEvent(value));
                          },
                          leading: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 30.sp,
                      color: Colors.blue[900],
                    ),
                  ],
                ),
              ),
            ),
            body: state.screenStatus == ScreenStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : state.screenStatus == ScreenStatus.successfully
                    ? Column(
                        children: [
                          SizedBox(height: 10.h),
                          Expanded(
                            child: GridView.builder(
                              itemCount:
                                  state.productModel?.products?.length ?? 0,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: (192 / 237),
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16.h,
                                      crossAxisSpacing: 16.w),
                              itemBuilder: (context, index) {
                                fav = ProductListBloc.iDs?.contains(state
                                        .productModel?.products?[index].id
                                        .toString()) ??
                                    false;

                                return BlocProvider(
                                  create: (context) => getIt<ProductListBloc>(),
                                  child: ProductItem(
                                      productModel: state.productModel,
                                      index: index,
                                      fav: fav),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : const SizedBox(),
          );
        },
      ),
    );
  }
}
