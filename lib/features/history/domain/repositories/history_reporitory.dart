import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';

abstract class HistoryRepository {
  Future<DataState<List<HistoryEntity>>> getHistory();
}
