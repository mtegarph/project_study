import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project_study/core/resource/data_state.dart';
import 'package:project_study/features/history/domain/entities/history_entity.dart';
import 'package:dio/dio.dart';
import 'package:project_study/features/history/domain/usecases/get_history.dart';
part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryUseCase _getHistoryUseCase;
  HistoryBloc(this._getHistoryUseCase) : super(const HistoryLoading()) {
    on<GetHistory>(onGetHistory);
  }
  void onGetHistory(GetHistory event, Emitter<HistoryState> emit) async {
    final datastate = await _getHistoryUseCase();
    if (datastate is DataSuccess && datastate.data!.isNotEmpty) {
      emit(HistoryDone(datastate.data!));
    }
    if (datastate is DataFailed) {
      emit(HistoryFailed(datastate.error!));
    }
  }
}
