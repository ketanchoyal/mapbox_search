import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';

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
    );

    var searchPlace = search.getPlaces(
      "patio",
      location: Location(
        lat: -19.984634,
        lng: -43.9502958,
      ),
    );

    expect(searchPlace, completion(isA<List<MapBoxPlace>>()));
    expect(searchPlace, completion(isNotEmpty));
    expect(searchPlace, completion(hasLength(5)));
  });
}
