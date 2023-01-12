part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;

  const factory SearchState.searching(
    String query,
  ) = _Searching;

  const factory SearchState.loaded(
    String query,
    int? total,
    int? skip,
    int? limit,
    List<Product>? products,
  ) = _Loaded;

  const factory SearchState.error(
    String query,
    Failure failure,
  ) = _Error;
}
