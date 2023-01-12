import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machine_task/models/product.dart';

import '../../models/failure.dart';
import '../../data/source.dart';

part 'categories_cubit.freezed.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(const CategoriesState.initial());

  Future<void> fetch() async {
    final RemoteSource source = RemoteSource();
    final result = await source.getCategories();
    emit(CategoriesState.loaded(result));
  }
}
