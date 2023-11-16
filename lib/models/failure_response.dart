import 'package:json_annotation/json_annotation.dart';

part 'failure_response.g.dart';

@JsonSerializable()
class FailureResponse {
  final String? message;
  final String? error;
  final Map<String, dynamic> response;

  FailureResponse({
    required this.message,
    required this.error,
    required this.response,
  });

  factory FailureResponse.fromJson(Map<String, dynamic> json) =>
      _$FailureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FailureResponseToJson(this);
}
