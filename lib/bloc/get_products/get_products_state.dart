part of 'get_products_cubit.dart';

@freezed
class GetProductsState with _$GetProductsState {
  const factory GetProductsState.initial() = _Initial;

  const factory GetProductsState.loaded(
    int? total,
    int? skip,
    int? limit,
    List<Product>? products,
  ) = _Loaded;

  const factory GetProductsState.error(
    Failure failure,
  ) = _Error;
}
