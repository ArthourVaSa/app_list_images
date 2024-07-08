// coverage:ignore-file
import 'package:prueba_omni_pro_app/src/utils/utils.dart';

abstract class DataState<T> {

  final T? data;
  final ApiException? error;
  final Exception? exception;

  const DataState({
    this.data,
    this.error,
    this.exception,
  });

}

class DataSuccess<T> extends DataState<T> {

  const DataSuccess(T data) : super(data: data);

}

class DataApiError<T> extends DataState<T> {

  const DataApiError(ApiException error) : super(error: error);

}