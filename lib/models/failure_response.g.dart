// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failure_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailureResponse _$FailureResponseFromJson(Map<String, dynamic> json) =>
    FailureResponse(
      message: json['message'] as String?,
      error: json['error'] as String?,
      response: json['response'] as Map<String, dynamic>?,
      version: json['version'] as String?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$FailureResponseToJson(FailureResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'version': instance.version,
      'code': instance.code,
      'response': instance.response,
    };
