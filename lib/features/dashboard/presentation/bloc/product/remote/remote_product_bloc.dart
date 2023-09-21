import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/dashboard/domain/entities/data_entity.dart';
import 'package:project_study/features/dashboard/domain/usecase/get_product.dart';

import 'package:project_study/features/news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:project_study/features/news/domain/usecases/get_article.dart';

part 'remote_product_event.dart';
part 'remote_product_state.dart';

class RemoteProductBloc extends Bloc<RemoteProductEvent, RemoteProductState> {
  final GetProductUseCase _getProductUseCase;
  RemoteProductBloc(this._getProductUseCase)
      : super(const RemoteProductLoading()) {
    on<GetProducts>(onGetProducts);
  }
  void onGetProducts(
      GetProducts event, Emitter<RemoteProductState> emit) async {
    final dataState = await _getProductUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteProductDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteProductFailed(dataState.error!));
    }
  }
}
