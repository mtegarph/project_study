import 'package:project_study/core/constant/constant.dart';
import 'package:project_study/features/dashboard/data/model/data_model.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
part 'product_api_service.g.dart';

@RestApi(baseUrl: produtApiBaseUrl)
abstract class ProductApiService {
  factory ProductApiService(Dio dio) = _ProductApiService;
  @GET("/products")
  Future<HttpResponse<List<Product>>> getProduct();
}
