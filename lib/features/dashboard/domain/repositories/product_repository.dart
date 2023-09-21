import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/dashboard/domain/entities/data_entity.dart';

abstract class ProductRepository {
  Future<DataState<List<ProductEntity>>> getProduct();
}
