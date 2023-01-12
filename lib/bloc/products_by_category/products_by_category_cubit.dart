
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/failure.dart';
import '../../models/product.dart';
import '../../data/source.dart';

part 'products_by_category_cubit.freezed.dart';

part 'products_by_category_state.dart';

class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  ProductsByCategoryCubit() : super(const ProductsByCategoryState.initial());

  Future<void> fetch(String category) async {
    emit(const ProductsByCategoryState.initial());
    final RemoteSource source = RemoteSource();
    final result = await source.getProductsByCategory(category: category);
    emit(ProductsByCategoryState.loaded(
      category,
      result.total,
      result.skip,
      result.limit,
      result.products,
    ));
  }
}
