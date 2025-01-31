import 'package:json_annotation/json_annotation.dart';

part 'failure_response.g.dart';

@JsonSerializable()
class FailureResponse {
  final String? message;
  final String? error;
  final String? version;
  final String? code;
  final Map<String, dynamic>? response;

  FailureResponse({
    this.message,
    this.error,
    this.response,
    this.version,
    this.code,
  });

  factory FailureResponse.fromJson(Map<String, dynamic> json) =>
      _$FailureResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FailureResponseToJson(this);
}
