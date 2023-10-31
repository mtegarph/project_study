import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/history/data/models/history.dart';
import 'package:project_study/features/history/data/repositories/history_repository.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';
import 'package:retrofit/dio.dart';
import 'package:dio/dio.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHistorApiServices mockHistorApiServices;
  late HistoryRepositoryImpl historyRepositoryImpl;

  setUp(() {
    mockHistorApiServices = MockHistorApiServices();
    historyRepositoryImpl = HistoryRepositoryImpl(mockHistorApiServices);
  });
  var history = History(carts: <CartElement>[], total: 12, skip: 12, limit: 12);

  final tHistoryList = <HistoryEntity>[];

  group('Calling api history', () {
    test('should return history when call to data source successful', () async {
      //arange
      when(mockHistorApiServices.getProduct()).thenAnswer((_) async =>
          HttpResponse(
              history,
              Response(
                  requestOptions: RequestOptions(),
                  data: history,
                  statusCode: 200)));
//act
      final result = await historyRepositoryImpl.getHistory();
//assert
      print('Expected: $tHistoryList');
      print('Actual: $result');
      expect((result as DataSuccess).data, equals(tHistoryList));
    });
    test('should return server failure call to data source unsuccessful',
        () async {
      //arange
      when(mockHistorApiServices.getProduct()).thenAnswer((_) async =>
          HttpResponse(
              history,
              Response(
                  requestOptions: RequestOptions(),
                  data: history,
                  statusCode: 404)));
//act
      final result = await historyRepositoryImpl.getHistory();
//assert
      print('Expected: $tHistoryList');
      print('Actual: $result');
      expect(result, isA<DataFailed<List<HistoryEntity>>>());
    });
  });
}
