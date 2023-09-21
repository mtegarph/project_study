import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/core/usecases/usecase.dart';
import 'package:project_study/features/dashboard/domain/entities/data_entity.dart';
import 'package:project_study/features/dashboard/domain/repositories/product_repository.dart';

class GetProductUseCase
    implements UseCase<DataState<List<ProductEntity>>, void> {
  final ProductRepository productRepository;

  GetProductUseCase(this.productRepository);

  @override
  Future<DataState<List<ProductEntity>>> call({void params}) {
    // TODO: implement call
    return productRepository.getProduct();
  }
}
