import 'dart:io';

import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/history/data/datasources/remote/history_api_services.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';
import 'package:project_study/features/history/domain/repositories/history_reporitory.dart';
import 'package:dio/dio.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistorApiServices historApiServices;
  HistoryRepositoryImpl(this.historApiServices);
  @override
  Future<DataState<List<HistoryEntity>>> getHistory() async {
    final httpresponse = await historApiServices.getProduct();

    try {
      if (httpresponse.response.statusCode == HttpStatus.ok) {
        List<HistoryEntity> history = [];
        httpresponse.data.carts.forEach((element) {
          element.products.forEach((element2) {
            history.add(HistoryEntity(
                thumbnail: element2.thumbnail,
                discountPercentage: element2.discountPercentage,
                discountedPrice: element2.discountedPrice,
                price: element2.price,
                quantity: element2.quantity,
                title: element2.title,
                total: element2.total));
          });
        });
        return DataSuccess(history);
      } else {
        return DataFailed(DioException(
            error: httpresponse.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: httpresponse.response,
            requestOptions: httpresponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
