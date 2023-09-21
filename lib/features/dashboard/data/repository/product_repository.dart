import 'dart:io';

import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/dashboard/data/data_source/remote/product_api_service.dart';
import 'package:project_study/features/dashboard/domain/entities/data_entity.dart';
import 'package:project_study/features/dashboard/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductApiService productApiService;

  ProductRepositoryImpl(this.productApiService);
  @override
  Future<DataState<List<ProductEntity>>> getProduct() async {
    final httpResponse = await productApiService.getProduct();
    try {
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
