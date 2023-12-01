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
          return state.screenStatus == ScreenStatus.loading
              ? const Center(child: CircularProgressIndicator())
              : state.screenStatus == ScreenStatus.successfully
                  ? Scaffold(
                      appBar: AppBar(
                        title: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Color(0xFF004182)),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 1, color: Color(0xFF004182)),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                        color: Color(0xFF06004E),
                                      ),
                                      hintText: 'what do you search for?',
                                      hintStyle: TextStyle(
                                        color: const Color(0x9906004E),
                                        fontSize: 17.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.shopping_cart_outlined,
                                size: 30.0.sp,
                                color: Colors.blue[900],
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Column(
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Expanded(
                            child: GridView.builder(
                              itemCount: state.productModel?.products?.length,
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
                      ),
                    )
                  : const SizedBox();
        },
      ),
    );
  }
}
