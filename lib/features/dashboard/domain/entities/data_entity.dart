import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final int? price;
  final int? stock;

  const ProductEntity(
      {this.id, this.title, this.description, this.price, this.stock});
  @override
  // TODO: implement props
  List<Object?> get props => [id, title, description, price, stock];
}
