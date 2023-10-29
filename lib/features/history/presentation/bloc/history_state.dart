part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  final List<HistoryEntity>? history;
  final DioException? error;
  const HistoryState({this.error, this.history});

  @override
  List<Object> get props => [error!, history!];
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryDone extends HistoryState {
  const HistoryDone(List<HistoryEntity> history) : super(history: history);
}

class HistoryFailed extends HistoryState {
  const HistoryFailed(DioException error) : super(error: error);
}
