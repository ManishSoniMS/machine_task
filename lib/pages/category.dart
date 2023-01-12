import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_task/bloc/categories/categories_cubit.dart';

import '../bloc/products_by_category/products_by_category_cubit.dart';
import 'product_by_category.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CategoriesCubit>().fetch();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Categories"),
      ),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          return state.map(
            initial: (_) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            loaded: (loaded) {
              return ListView.builder(
                itemCount: loaded.categories.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
                itemBuilder: (context, index) {
                  final category = loaded.categories[index];
                  return InkWell(
                    onTap: () {
                      context.read<ProductsByCategoryCubit>().fetch(category);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ProductsByCategory()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)),
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      margin: const EdgeInsets.symmetric(vertical: 7.5),
                      child: Center(
                        child: Text(
                          category,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                  );
                },
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
    );
  }
}
