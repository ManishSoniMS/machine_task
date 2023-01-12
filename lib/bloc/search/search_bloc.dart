import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/failure.dart';
import '../../models/product.dart';
import '../../data/source.dart';

part 'search_bloc.freezed.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchState.initial()) {
    on<_Search>(_onSearch);
    on<_Clear>(_onClear);
  }

  Future<void> _onSearch(_Search event, Emitter<SearchState> emit) async {
    emit(SearchState.searching(event.query));
    final RemoteSource source = RemoteSource();
    final result = await source.getAllProducts();
    emit(SearchState.loaded(
      event.query,
      result.total,
      result.skip,
      result.limit,
      result.products,
    ));
  }

  Future<void> _onClear(_Clear event, Emitter<SearchState> emit) async {
    final RemoteSource source = RemoteSource();
    final result = await source.getAllProducts();
    emit(const SearchState.initial());
  }
}
