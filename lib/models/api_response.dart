import 'package:mapbox_search/models/failure_response.dart';

typedef ApiResponse<T> = ({T? success, FailureResponse? failure});

extension ApiResponseExtension<T> on ApiResponse<T> {
  R fold<R extends Object?>(
    R Function(T value) success,
    R Function(FailureResponse value) failure,
  ) {
    if (this.success != null) {
      return success(this.success!);
    } else if (this.failure != null) {
      return failure(this.failure!);
    } else {
      throw Exception('ApiResponse is not valid');
    }
  }
}
