part of mapbox_search;

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
      FailureResponse(
        message: json["message"],
        error: json["error"],
        response: json,
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'error': error,
        'response': response,
      };
}
