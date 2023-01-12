import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_details/product_details_cubit.dart';
import '../bloc/search/search_bloc.dart';
import '../widgets/product_tile.dart';
import '../widgets/search_bar.dart';
import 'product_details.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              expandedHeight: kToolbarHeight * 1.2,
              flexibleSpace: Row(children: [
                BackButton(onPressed: () {
                  context.read<SearchBloc>().add(const SearchEvent.clear());
                  Navigator.of(context).pop();
                }),
                const Expanded(child: SearchBar(left: 0))
              ]),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text("Search Something!!"),
                      ),
                    );
                  },
                  searching: (_) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  loaded: (loaded) {
                    return SliverGrid(
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
                    );
                  },
                  error: (error) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(error.failure.message),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
