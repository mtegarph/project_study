import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';
import 'package:project_study/features/history/domain/usecases/get_history.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetHistoryUseCase getHistoryUseCase;
  late MockHistoryRepository mockHistoryRepository;

  setUp(() {
    mockHistoryRepository = MockHistoryRepository();
    getHistoryUseCase = GetHistoryUseCase(mockHistoryRepository);
  });

  const List<HistoryEntity> mockdata = [
    HistoryEntity(
        discountPercentage: 23,
        discountedPrice: 123,
        price: 123,
        quantity: 4,
        title: 'test',
        total: 12,
        thumbnail: "test"),
    HistoryEntity(
        discountPercentage: 23,
        discountedPrice: 123,
        price: 123,
        quantity: 4,
        title: 'test',
        total: 12,
        thumbnail: "test"),
    HistoryEntity(
        discountPercentage: 23,
        discountedPrice: 123,
        price: 123,
        quantity: 4,
        title: 'test',
        total: 12,
        thumbnail: "test"),
  ];

  group("get history from use case", () {
    test("should get history from repository success", () async {
      // Arrange
      when(mockHistoryRepository.getHistory()).thenAnswer(
          (_) async => const DataSuccess<List<HistoryEntity>>(mockdata));
      // Act
      final result = await getHistoryUseCase.call();
      // Assert
      expect(result, const DataSuccess<List<HistoryEntity>>(mockdata));
      //verify(() => mockHistoryRepository.getHistory()).called(1);
    });

    test("should handle error from repository", () async {
      // Arrange
      when(mockHistoryRepository.getHistory()).thenThrow(Exception());

      // Act
      final call = getHistoryUseCase.call;

      // Assert
      expect(() => call(), throwsA(isA<Exception>()));
      //verify(() => mockHistoryRepository.getHistory()).called(1);
    });
  });
}
