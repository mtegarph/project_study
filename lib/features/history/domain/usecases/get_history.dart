import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/core/usecases/usecase.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';
import 'package:project_study/features/history/domain/repositories/history_reporitory.dart';

class GetHistoryUseCase
    implements UseCase<DataState<List<HistoryEntity>>, void> {
  final HistoryRepository historyRepository;
  GetHistoryUseCase(this.historyRepository);
  @override
  Future<DataState<List<HistoryEntity>>> call({void params}) {
    return historyRepository.getHistory();
  }
}
