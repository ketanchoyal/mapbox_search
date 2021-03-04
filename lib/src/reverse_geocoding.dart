part of mapbox_search;

class ReverseGeoCoding {
  /// API Key of the MapBox.
  final String apiKey;

  /// Specify the user’s language. This parameter controls the language of the text supplied in responses.
  ///
  /// Check the full list of [supported languages](https://docs.mapbox.com/api/search/#language-coverage) for the MapBox API
  final String language;

  /// The point around which you wish to retrieve place information.
  final Location location;

  /// Specify the maximum number of results to return. The default is 5 and the maximum supported is 10.
  final int limit;

  ///Limit results to one or more countries. Permitted values are ISO 3166 alpha 2 country codes separated by commas.
  ///
  /// Check the full list of [supported countries](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for the MapBox API
  final String country;

  final String _url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/';

  ReverseGeoCoding({
    this.apiKey,
    this.language,
    this.location,
    this.limit,
    this.country,
  }) : assert(apiKey != null);

  String _createUrl(Location location) {
    String finalUrl = _url +
        location.lng.toString() +
        "," +
        location.lat.toString() +
        '.json?';
    finalUrl += 'access_token=$apiKey';

    if (this.location != null) {
      finalUrl += '&proximity=${this.location.lng}%2C${this.location.lat}';
    }

    if (limit != null) {
      finalUrl += '&limit=$limit&types=address';
    }

    if (country != null) {
      finalUrl += '&country=$country';
    }

    if (language != null) {
      finalUrl += '&language=$language';
    }

    return finalUrl;
  }

  Future<List<MapBoxPlace>> getAddress(Location location) async {
    String url = _createUrl(location);
    final response = await http.get(Uri.parse(url));

    if (response?.body?.contains('message') ?? false) {
      throw Exception(json.decode(response.body)['message']);
    }

    return Predictions.fromRawJson(response.body).features;
  }
}
