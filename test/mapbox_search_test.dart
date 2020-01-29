import 'package:flutter_test/flutter_test.dart';
import 'package:mapbox_search/mapbox_search.dart';

void main() async {
  String apiKey; //Set up a test api key before testing

  test("Has api key", () {
    expect(apiKey, isNotNull);
  });

  test("Places search test", () async {
    var search = PlacesSearch(
      apiKey: apiKey,
      country: "BR",
      limit: 5,
      location: Location(
        lat: -19.984634,
        lng: -43.9502958,
      ),
    );

    var searchPlace = search.getPlaces("patio");

    expect(searchPlace, completion(isA<List<MapBoxPlace>>()));
    expect(searchPlace, completion(isNotEmpty));
    expect(searchPlace, completion(hasLength(5)));
  });
}
