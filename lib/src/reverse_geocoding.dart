part of mapbox_search;

class ReverseGeoCoding {
  /// API Key of the MapBox.
  final String apiKey;

  /// Specify the user’s language. This parameter controls the language of the text supplied in responses.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String? language;

  /// The point around which you wish to retrieve place information.
  final Location? location;

  /// Specify the maximum number of results to return. Maximum supported is 10.
  ///
  /// If limit is not specified, the default is 1(MapBox Api default behaviour).
  ///
  /// If you wan to use limit then please just pass only one [PlaceType], this is a known limitiation of the MapBox API
  final int? limit;

  ///Limit results to one or more countries. Permitted values are ISO 3166 alpha 2 country codes separated by commas.
  ///
  /// Check the full list of [supported countries](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for the MapBox API
  final String? country;

  /// Filter results to include only a subset (one or more) of the available feature types.
  /// Options are country, region, postcode, district, place, locality, neighborhood, address, and poi.
  /// Multiple options can be comma-separated.
  ///
  /// For more information on the available types, see the [data types section](https://docs.mapbox.com/api/search/geocoding/#data-types).
  final List<PlaceType> types;

  final Uri _baseUri =
      Uri.parse('https://api.mapbox.com/geocoding/v5/mapbox.places/');

  ReverseGeoCoding({
    required this.apiKey,
    this.language,
    this.location,
    this.limit,
    this.country,
    this.types = const [PlaceType.address],
  });

  Uri _createUrl(Location location) {
    final finalUri = Uri(
      scheme: _baseUri.scheme,
      host: _baseUri.host,
      path: _baseUri.path + location.asString + '.json',
      queryParameters: {
        'access_token': apiKey,
        if (country != null) 'country': country,
        if (limit != null) 'limit': limit.toString(),
        if (language != null) 'language': language,
        'types': types.map((e) => e.value).join(','),
      },
    );

    return finalUri;
  }

  Future<List<MapBoxPlace>?> getAddress(Location location) async {
    // Assert that if limit is not null then only one type is passed
    assert(limit != null && (types.length == 1) || limit == null,
        'Limit is not null so you can only pass one type');
    Uri uri = _createUrl(location);
    final response = await http.get(uri);

    if (response.body.contains('message')) {
      throw Exception(json.decode(response.body)['message']);
    }

    return Predictions.fromRawJson(response.body).features;
  }
}
