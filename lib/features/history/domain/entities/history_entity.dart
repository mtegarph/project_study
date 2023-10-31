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
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HistoryEntity &&
        other.thumbnail == thumbnail &&
        other.discountPercentage == discountPercentage &&
        other.discountedPrice == discountedPrice &&
        other.price == price &&
        other.quantity == quantity &&
        other.title == title &&
        other.total == total;
  }

  @override
  int get hashCode {
    return thumbnail.hashCode ^
        discountPercentage.hashCode ^
        discountedPrice.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        title.hashCode ^
        total.hashCode;
  }

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
