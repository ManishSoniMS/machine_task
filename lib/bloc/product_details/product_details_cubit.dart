import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machine_task/models/failure.dart';
import 'package:machine_task/models/product.dart';

import '../../data/source.dart';

part 'product_details_cubit.freezed.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(const ProductDetailsState.initial());

  Future<void> fetch(int productId) async {
    emit(const ProductDetailsState.initial());
    final RemoteSource source = RemoteSource();
    final result = await source.getProductById(productId);
    emit(ProductDetailsState.loaded(result));
  }
}
