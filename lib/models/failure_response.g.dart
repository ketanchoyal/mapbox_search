// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailureResponse _$FailureResponseFromJson(Map<String, dynamic> json) =>
    FailureResponse(
      message: json['message'] as String?,
      error: json['error'] as String?,
      response: json['response'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$FailureResponseToJson(FailureResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'response': instance.response,
    };
