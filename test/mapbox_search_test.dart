import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  test("Places search test", () async {
    PlacesSearch search = PlacesSearch(
      apiKey: MAPBOX_KEY,
      country: "BR",
      limit: 5,
      types: [PlaceType.address, PlaceType.place],
    );

    var searchPlace = search.getPlaces(
      "central park",
      proximity: Location(
        lat: -19.984634,
        lng: -43.9502958,
      ),
    );

    expect(searchPlace, completion(isA<List<MapBoxPlace>>()));
    expect(searchPlace, completion(isNotEmpty));
    expect(searchPlace, completion(hasLength(5)));
  });
}
