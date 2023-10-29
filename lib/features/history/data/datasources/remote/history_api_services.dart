import 'package:project_study/core/constant/constant.dart';
import 'package:project_study/features/dashboard/data/model/data_model.dart';
import 'package:project_study/features/history/data/models/history.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'history_api_services.g.dart';

@RestApi(baseUrl: produtApiBaseUrl)
abstract class HistorApiServices {
  factory HistorApiServices(Dio dio) = _HistorApiServices;
  @GET("/carts")
  Future<HttpResponse<History>> getProduct();
}
