import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:project_study/features/history/data/models/history.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';

import '../../helpers/json_reader.dart';

void main() {
  final testProductModel = Product(
      id: 1,
      title: '121',
      price: 12,
      quantity: 12,
      total: 12,
      discountPercentage: 12,
      discountedPrice: 12,
      thumbnail: '');
  final testHistoryModel = History(carts: <CartElement>[
    CartElement(
        id: 1,
        products: [],
        total: 2328,
        discountedTotal: 1941,
        userId: 97,
        totalProducts: 5,
        totalQuantity: 10),
    CartElement(
        id: 2,
        products: <Product>[
          Product(
              id: 9,
              title: 'Infinix INBOOK',
              price: 1099,
              quantity: 1,
              total: 1099,
              discountPercentage: 11.83,
              discountedPrice: 969,
              thumbnail:
                  'https://i.dummyjson.com/data/products/9/thumbnail.jpg'),
          Product(
              id: 16,
              title: 'Hyaluronic Acid Serum',
              price: 19,
              quantity: 1,
              total: 19,
              discountPercentage: 13.31,
              discountedPrice: 16,
              thumbnail:
                  'https://i.dummyjson.com/data/products/16/thumbnail.jpg'),
          Product(
              id: 54,
              title: 'Pubg Printed Graphic T-Shirt',
              price: 46,
              quantity: 3,
              total: 138,
              discountPercentage: 16.44,
              discountedPrice: 115,
              thumbnail:
                  'https://i.dummyjson.com/data/products/54/thumbnail.jpg')
        ],
        total: 3023,
        discountedTotal: 2625,
        userId: 30,
        totalProducts: 5,
        totalQuantity: 10),
  ], total: 2, skip: 0, limit: 20);
  group("history model test", () {
    test('should be subclass of history entity', () {
      expect(testProductModel, isA<HistoryEntity>());
    });
    test('should return valid model from json', () async {
      //arange
      final Map<String, dynamic> fromJson = json
          .decode(readJson('helpers/dummy_data/dummy_history_response.json'));
      //act
      final result = History.fromJson(fromJson);
      //asseert
      //To fix this, you need to compare the objects by value. One way to do this is to compare the toJson() output of both objects,
      //which will be a Map This will compare the objects by their values, not their references. If the content of the objects is the same, the test should pass.
      expect(result.toJson(), equals(testHistoryModel.toJson()));
    });
  });
}
