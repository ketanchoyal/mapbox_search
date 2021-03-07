import 'package:mapbox_search/mapbox_search.dart';

// import 'credentials.dart';
final MAPBOX_KEY = '';

Future<void> main() async {
  String apiKey = MAPBOX_KEY; //Set up a test api key before running

  await geoCoding(apiKey).catchError(print);
  await placesSearch(apiKey).catchError(print);
}

///Reverse GeoCoding sample call
Future geoCoding(String apiKey) async {
  var geoCodingService = ReverseGeoCoding(
    apiKey: apiKey,
    country: "BR",
    limit: 5,
  );

  var addresses = await geoCodingService.getAddress(Location(
    lat: -19.984846,
    lng: -43.946852,
  ));

  print(addresses);
}

///Places search sample call
Future placesSearch(String apiKey) async {
  var placesService = PlacesSearch(
    apiKey: apiKey,
    country: "BR",
    limit: 5,
  );

  var places = await placesService.getPlaces(
    "patio",
    location: Location(
      lat: -19.984634,
      lng: -43.9502958,
    ),
  );

  print(places);
}
