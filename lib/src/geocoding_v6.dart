import 'package:dio/dio.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search/models/location.dart';

/// The MapBox Geocoding API v6 lets you convert location text into geographic coordinates
/// and vice versa utilizing the new Search service.
///
/// https://docs.mapbox.com/api/search/geocoding/
class GeoCodingApiV6 {
  /// API Key of the MapBox.
  final String _apiKey;

  /// Specify the user’s language. This parameter controls the language of the text supplied in responses.
  final String? language;

  /// Limit results to one or more countries. Permitted values are ISO 3166 alpha 2 country codes separated by commas.
  final String? country;

  /// Specify the maximum number of results to return.
  final int? limit;

  /// Limit results to only those contained within the supplied bounding box.
  final BBox? bbox;

  /// Filter results to include only a subset (one or more) of the available feature types.
  final List<PlaceType> types;

  final Dio _dio;

  final _baseUrl = 'https://api.mapbox.com';
  final _basePathForward = '/search/geocode/v6/forward';
  final _basePathReverse = '/search/geocode/v6/reverse';
  final _basePathBatch = '/search/geocode/v6/batch';

  /// If [apiKey] is not provided here then it must be provided [MapBoxSearch()]
  GeoCodingApiV6({
    String? apiKey,
    this.country,
    this.limit,
    this.language,
    this.types = const [],
    this.bbox,
    Dio? dio,
  }) : assert(
         apiKey != null || MapBoxSearch.apiKey != null,
         'The API Key must be provided',
       ),
       _dio = dio ?? Dio(),
       _apiKey = apiKey ?? MapBoxSearch.apiKey! {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.queryParameters = <String, String>{
      'access_token': _apiKey,
      'country': ?country,
      // limit is handled dynamically in requests
      'language': ?language,
      if (types.isNotEmpty) 'types': types.map((e) => e.value).join(','),
      'bbox': ?bbox?.asString,
    };
    _dio.options.receiveDataWhenStatusError = true;
  }

  /// Get the places for the given query text (Forward Geocoding)
  Future<ApiResponse<GeocodingResponseV6>> forward(
    String queryText, {
    Proximity proximity = const NoProximity(),
    bool permanent = false,
    bool autocomplete = false,
    int? limit,
    CancelToken? cancelToken,
  }) async {
    final effectiveLimit = limit ?? this.limit;
    final Map<String, dynamic> queryParameters = {
      'q': queryText,
      'permanent': permanent,
      'autocomplete': autocomplete,
      'limit': ?effectiveLimit?.toString(),
      ...switch (proximity) {
        (LocationProximity l) => {"proximity": l.asString},
        (IpProximity ip) => {"proximity": ip.asString},
        (NoProximity _) => {},
      },
    };

    try {
      final response = await _dio.get(
        _basePathForward,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Get the address of the given location coordinates (Reverse Geocoding)
  Future<ApiResponse<GeocodingResponseV6>> reverse(
    Location location, {
    bool permanent = false,
    int? limit,
    List<PlaceType>? types,
    CancelToken? cancelToken,
  }) async {
    final effectiveLimit = limit ?? this.limit;
    final effectiveTypes = types ?? this.types;

    // Validation: limit > 1 requires types
    var limitToSend = effectiveLimit;
    if (effectiveLimit != null &&
        effectiveLimit > 1 &&
        effectiveTypes.isEmpty) {
      print(
        'Warning: Mapbox Geocoding v6 Reverse API requires "types" to be specified when "limit" is greater than 1. Forcing limit to 1.',
      );
      limitToSend = 1;
    }

    final Map<String, dynamic> queryParameters = {
      'longitude': location.long,
      'latitude': location.lat,
      'permanent': permanent,
      'limit': ?limitToSend?.toString(),
      if (types != null && types.isNotEmpty)
        'types': types.map((e) => e.value).join(','),
    };

    try {
      final response = await _dio.get(
        _basePathReverse,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// Perform a batch geocoding request.
  ///
  /// Supports up to 1000 queries.
  Future<ApiResponse<BatchGeocodingResponse>> batch(
    List<BatchQuery> queries, {
    bool permanent = false,
    CancelToken? cancelToken,
  }) async {
    final List<Map<String, dynamic>> body = queries
        .map((q) => q.toJson())
        .toList();

    try {
      final response = await _dio.post(
        _basePathBatch,
        data: body,
        queryParameters: {'permanent': permanent},
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        return (
          success: null,
          failure: FailureResponse.fromJson(response.data),
        );
      } else {
        return (
          success: BatchGeocodingResponse.fromJson(response.data),
          failure: null,
        );
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return _handleError(e);
    }
  }

  ApiResponse<GeocodingResponseV6> _handleResponse(Response response) {
    if (response.statusCode != 200) {
      return (success: null, failure: FailureResponse.fromJson(response.data));
    } else {
      return (
        success: GeocodingResponseV6.fromJson(response.data),
        failure: null,
      );
    }
  }

  ApiResponse<T> _handleDioError<T>(DioException e) {
    return (
      success: null,
      failure: FailureResponse(
        message: e.message ?? 'Unknown error',
        error: e.error.toString(),
        code: e.response?.statusCode.toString(),
      ),
    );
  }

  ApiResponse<T> _handleError<T>(Object e) {
    return (
      success: null,
      failure: FailureResponse(
        message: e.toString(),
        error: e.toString(),
        code: '500',
      ),
    );
  }
}
