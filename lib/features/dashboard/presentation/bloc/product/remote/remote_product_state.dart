part of 'remote_product_bloc.dart';

abstract class RemoteProductState extends Equatable {
  final List<ProductEntity>? product;
  final DioException? error;

  const RemoteProductState({this.product, this.error});

  @override
  List<Object> get props => [product!, error!];
}

final class RemoteProductLoading extends RemoteProductState {
  const RemoteProductLoading();
}

final class RemoteProductDone extends RemoteProductState {
  const RemoteProductDone(List<ProductEntity> article)
      : super(product: article);
}

final class RemoteProductFailed extends RemoteProductState {
  const RemoteProductFailed(DioException error) : super(error: error);
}
