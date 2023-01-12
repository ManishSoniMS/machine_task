import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/failure.dart';
import '../../models/product.dart';
import '../../data/source.dart';

part 'get_products_cubit.freezed.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(const GetProductsState.initial());

  Future<void> fetch() async {
    final RemoteSource source = RemoteSource();
    final result = await source.getAllProducts();
    emit(GetProductsState.loaded(
        result.total, result.skip, result.limit, result.products));
  }
}
