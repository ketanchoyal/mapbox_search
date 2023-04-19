import 'package:mapbox_search/mapbox_search.dart';
import 'package:test/test.dart';
import 'credentials.dart' as c;

void main() async {
  final MAPBOX_KEY = c.MAPBOX_KEY;

  test("Has api key", () {
    expect(MAPBOX_KEY, isNotNull);
    expect(MAPBOX_KEY, isNotEmpty);
  });

  test("ReverseGeoCoding address search with limit test", () async {
    ReverseGeoCoding reverseGeoCoding = ReverseGeoCoding(
      apiKey: MAPBOX_KEY,
      country: "BR",
      limit: 2,
    );

    var addresses = reverseGeoCoding.getAddress(
      Location(
        lat: -19.984634,
        lng: -43.9502958,
      ),
    );

    expect(addresses, completion(isA<List<MapBoxPlace>>()));
    expect(addresses, completion(isNotEmpty));
    expect(addresses, completion(hasLength(2)));
  });
  test("ReverseGeoCoding address search without limit test", () async {
    ReverseGeoCoding reverseGeoCoding = ReverseGeoCoding(
      apiKey: MAPBOX_KEY,
      country: "BR",
      types: [PlaceType.address, PlaceType.place],
    );

    var addresses = reverseGeoCoding.getAddress(
      Location(
        lat: -19.984634,
        lng: -43.9502958,
      ),
    );

    expect(addresses, completion(isA<List<MapBoxPlace>>()));
    expect(addresses, completion(isNotEmpty));
    // expect(addresses, completion(hasLength(2)));
  });
}
