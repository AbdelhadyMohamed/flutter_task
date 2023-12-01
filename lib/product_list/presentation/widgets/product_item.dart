import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/ProductModel.dart';
import '../bloc/product_list_bloc.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final ProductModel? productModel;
  late bool fav;
  ProductItem(
      {required this.index,
      required this.productModel,
      required this.fav,
      super.key});

  @override
  Widget build(BuildContext context) {
    var product = productModel?.products?[index];
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              left: index.isEven ? 16.w : 0, right: index.isOdd ? 16.w : 0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                border: Border.all(width: 2.w, color: Colors.blueGrey)),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        child: CachedNetworkImage(
                            imageUrl: product?.thumbnail ?? "",
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: 191.h,
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error_outline, size: 40)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 7.w),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            // margin: const EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(2.h.w),

                            margin: EdgeInsets.only(left: 6.w),

                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                ProductListBloc.get(context)
                                    .add(ChangeFavIcon((!(fav))));
                                fav = !fav;
                                state.isFav = fav;
                              },
                              child: Icon(
                                state.isFav ?? fav
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        product?.title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        productModel?.products?[index].description ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SizedBox(width: 8.w),
                        Text("Egp ${product?.price.toString() ?? ""}"),
                        SizedBox(width: 16.w),
                        const Text("EGP 1200"),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    const Spacer(),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 8.w, bottom: 13.h, right: 8.w),
                      child: Row(
                        children: [
                          const Text("Review"),
                          SizedBox(width: 4.w),
                          Text(product?.rating.toString() ?? ""),
                          SizedBox(width: 4.w),
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          const Spacer(),
                          Container(
                              // padding: EdgeInsets.all(5.w.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.r),
                                color: Colors.blue[900],
                              ),
                              child: const Icon(Icons.add, color: Colors.white))
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}
