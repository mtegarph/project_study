import 'package:equatable/equatable.dart';

class HistoryEntity extends Equatable {
  final String? title;
  final int? price;
  final int? quantity;
  final int? total;
  final double? discountPercentage;
  final int? discountedPrice;
  final String? thumbnail;

  const HistoryEntity(
      {this.title,
      this.price,
      this.quantity,
      this.total,
      this.discountPercentage,
      this.discountedPrice,
      required this.thumbnail});
  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        price,
        quantity,
        total,
        discountPercentage,
        discountedPrice,
        thumbnail
      ];
}
