import 'package:dio/dio.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapbox_search/models/location.dart';

@Deprecated('Use `GeoCodingApi` instead')
typedef GeoCoding = GeoCodingApi;

/// The MapBox Geocoding API lets you convert location text into geographic coordinates (1600 Pennsylvania Ave NW → -77.0366,38.8971)
/// and vice versa (reverse geocoding).
///
/// https://docs.mapbox.com/api/search/geocoding/
class GeoCodingApi {
  /// API Key of the MapBox.
  final String _apiKey;

  /// Specify the user’s language. This parameter controls the language of the text supplied in responses.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String? language;

  ///Limit results to one or more countries. Permitted values are ISO 3166 alpha 2 country codes separated by commas.
  ///
  /// Check the full list of [supported countries](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for the MapBox API
  final String? country;

  /// Specify the maximum number of results to return. The default is 5 and the maximum supported is 10.
  final int? limit;

  /// Limit results to only those contained within the supplied bounding box.
  final BBox? bbox;

  /// Filter results to include only a subset (one or more) of the available feature types.
  /// Options are country, region, postcode, district, place, locality, neighborhood, address, and poi.
  /// Multiple options can be comma-separated.
  ///
  /// For more information on the available types, see the [data types section](https://docs.mapbox.com/api/search/geocoding/#data-types).
  final List<PlaceType> types;

  // final Uri _baseUri =
  //     Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/');

  final Dio _dio;

  final _baseUrl = 'https://api.mapbox.com';
  final _basePath = '/geocoding/v5/mapbox.places/';

  /// If [apiKey] is not provided here then it must be provided [MapBoxSearch()]
  GeoCodingApi({
    String? apiKey,
    this.country,
    this.limit,
    this.language,
    this.types = const [PlaceType.address],
    this.bbox,
    Dio? dio,
  })  :

        /// Assert that the [apiKey] and [MapBoxSearch._apiKey] are not null at same time
        assert(
          apiKey != null || MapBoxSearch.apiKey != null,
          'The API Key must be provided',
        ),
        _dio = dio ?? Dio(),
        _apiKey = apiKey ?? MapBoxSearch.apiKey! {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.queryParameters = {
      'access_token': _apiKey,
      if (country != null) 'country': country,
      if (limit != null) 'limit': limit.toString(),
      if (language != null) 'language': language,
      if (types.isNotEmpty) 'types': types.map((e) => e.value).join(','),
      if (bbox != null) 'bbox': bbox?.asString,
    };
    _dio.options.receiveDataWhenStatusError = true;
  }

  /// Get the places for the given query text
  Future<ApiResponse<List<MapBoxPlace>>> getPlaces(
    String queryText, {
    Proximity proximity = const NoProximity(),
    CancelToken? cancelToken,
  }) async {
    final path = _basePath + Uri.encodeFull(queryText) + '.json';

    final Map<String, dynamic> queryParameters = {
      ...switch (proximity) {
        (LocationProximity l) => {"proximity": l.asString},
        (IpProximity ip) => {"proximity": ip.asString},
        (NoProximity _) => {},
      },
    };
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        return (
          success: null,
          failure: FailureResponse.fromJson(response.data)
        );
      } else {
        return (
          success: Predictions.fromJson(response.data).features,
          failure: null
        );
      }
    } on DioException catch (e) {
      return (
        success: null,
        failure: FailureResponse(
          message: e.message ?? 'Unknown error',
          error: e.error.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    } catch (e) {
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

  /// Get the address of the given location coordinates
  Future<ApiResponse<List<MapBoxPlace>?>> getAddress(
    Location location, {
    CancelToken? cancelToken,
  }) async {
    // Assert that if limit is not null then only one type is passed
    assert(limit != null && (types.length == 1) || limit == null,
        'Limit is not null so you can only pass one type');
    final path = _basePath + Uri.encodeFull(location.asString) + '.json';
    try {
      final response = await _dio.get(
        path,
        cancelToken: cancelToken,
      );

      if (response.statusCode != 200) {
        return (
          success: null,
          failure: FailureResponse.fromJson(response.data)
        );
      } else {
        return (
          success: Predictions.fromJson(response.data).features,
          failure: null
        );
      }
    } on DioException catch (e) {
      return (
        success: null,
        failure: FailureResponse(
          message: e.message ?? 'Unknown error',
          error: e.error.toString(),
          code: e.response?.statusCode.toString(),
        ),
      );
    } catch (e) {
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
}
