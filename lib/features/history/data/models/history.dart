// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';

class History {
  List<CartElement> carts;
  int total;
  int skip;
  int limit;

  History({
    required this.carts,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        carts: List<CartElement>.from(
            json["carts"].map((x) => CartElement.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "carts": List<dynamic>.from(carts.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is History &&
        listEquals(other.carts,
            carts) && // You need to import 'package:flutter/foundation.dart' to use listEquals
        other.total == total &&
        other.skip == skip &&
        other.limit == limit;
  }

  @override
  int get hashCode =>
      carts.hashCode ^ total.hashCode ^ skip.hashCode ^ limit.hashCode;
}

class CartElement {
  int id;
  List<Product> products;
  int total;
  int discountedTotal;
  int userId;
  int totalProducts;
  int totalQuantity;

  CartElement({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory CartElement.fromJson(Map<String, dynamic> json) => CartElement(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        discountedTotal: json["discountedTotal"],
        userId: json["userId"],
        totalProducts: json["totalProducts"],
        totalQuantity: json["totalQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "discountedTotal": discountedTotal,
        "userId": userId,
        "totalProducts": totalProducts,
        "totalQuantity": totalQuantity,
      };
}

// ignore: must_be_immutable
class Product extends HistoryEntity {
  int id;
  String title;
  int price;
  int quantity;
  int total;
  double discountPercentage;
  int discountedPrice;
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedPrice,
    required this.thumbnail,
  }) : super(
            thumbnail: thumbnail,
            discountPercentage: discountPercentage,
            discountedPrice: discountedPrice,
            price: price,
            quantity: quantity,
            title: title,
            total: total);

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        discountedPrice: json["discountedPrice"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
        "total": total,
        "discountPercentage": discountPercentage,
        "discountedPrice": discountedPrice,
        "thumbnail": thumbnail,
      };
}
