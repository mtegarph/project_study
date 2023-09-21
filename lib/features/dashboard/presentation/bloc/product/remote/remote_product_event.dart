part of 'remote_product_bloc.dart';

abstract class RemoteProductEvent extends Equatable {
  const RemoteProductEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends RemoteProductEvent {
  const GetProducts();
}
