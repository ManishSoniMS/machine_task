import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_task/pages/product_details.dart';

import '../bloc/product_details/product_details_cubit.dart';
import '../bloc/products_by_category/products_by_category_cubit.dart';
import '../widgets/product_tile.dart';

class ProductsByCategory extends StatelessWidget {
  const ProductsByCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProductsByCategoryCubit, ProductsByCategoryState>(
          builder: (context, state) {
            return state.map(
              initial: (_) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              loaded: (loaded) {
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      pinned: false,
                      snap: true,
                      floating: true,
                      automaticallyImplyLeading: true,
                      expandedHeight: kToolbarHeight,
                      title: Text(loaded.category),
                    ),
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200.0,
                        crossAxisSpacing: 0,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final prod = loaded.products![index];
                          return ProductTile(
                            onTap: () {
                              context
                                  .read<ProductDetailsCubit>()
                                  .fetch(prod.id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductDetails()));
                            },
                            prod: prod,
                          );
                        },
                        childCount: loaded.products!.length,
                      ),
                    )
                  ],
                );
              },
              error: (error) {
                return Center(
                  child: Text(error.failure.message),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
