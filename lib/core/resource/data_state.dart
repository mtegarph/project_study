import 'package:dio/dio.dart';

/// this class is for determine where is the data or when the comunicate network call is face
abstract class DataState<T> {
  final T? data;
  final DioException? error;
  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DataSuccess<T> && other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}
