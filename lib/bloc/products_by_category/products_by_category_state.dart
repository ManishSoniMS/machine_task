part of 'products_by_category_cubit.dart';

@freezed
class ProductsByCategoryState with _$ProductsByCategoryState {
  const factory ProductsByCategoryState.initial() = _Initial;

  const factory ProductsByCategoryState.loaded(
    String category,
    int? total,
    int? skip,
    int? limit,
    List<Product>? products,
  ) = _Loaded;

  const factory ProductsByCategoryState.error(
    String category,
    Failure failure,
  ) = _Error;
}
