[![Pub](https://img.shields.io/pub/v/mapbox_search)](https://pub.dev/packages/mapbox_search) 
# About

## Note: Breaking Changes in 4.x.x

- PlaceSearch and ReverseGeoCoding classes are now merged into one class called GeoCoding with two methods `getPlaces` and `getAddress` since both of them are using the same API.
- MapBox's new [SearchBox API](https://docs.mapbox.com/api/search/search-box/) is added to the package.
- Instead of throwing exceptions, the package now returns `ApiResponse` Record which can be either `Success` or `Failure` and can be handled using `fold` method.
- Location class is now converted to a record.
- List of coordinates are now converted to a record `(lat: double, long: doube)` whereever possible.

This package provides easy api calls to MapBox Search API. 

Also, it contains an static map image generator.

[Maki Icons](https://labs.mapbox.com/maki-icons/) can be used now in marker icon

As this package doesn't depend on Flutter SDK you cannot use the `Colors` class anymore on you Flutter project.
Instead use map_box_search's `Color.rgb` constructor, passing the values as parameters:

```dart
var myColor = Colors.redAccent; //Flutter's Color class
var mapBoxColor = Color.rgb( myColor.red, myColor.green, myColor.blue);
```

## Installing

First of all you must acquire an API key on the MapBox website https://www.mapbox.com/

Then, add the following to your `pubspec.yaml` file:

    dependencies:
      mapbox_search: any

## Setup
 Now you can setup the API key for whole app by calling `MapBoxSearch.init('API KEY')` in your `main()` function, this way you don't have to pass the API key to every class that uses the package.

### Usage of `ApiResponse`
```dart
final ApiResponse<List<MapBoxPlace>> addresses = await getAddress();
addresses.fold(
    (success) => // Do something with success data,
    (failure) => // Do something with failure data,
  );
```

# Examples

### SearchBox API
```dart
SearchBoxAPI search = SearchBoxAPI(
      apiKey: 'API Key', // dont pass if you have set it in MapBoxSearch.init('API KEY')
      limit: 6,
);
```
  ##### Get Suggestions
  ```dart
  ApiResponse<SuggestionResponse> searchPlace = await search.getSuggestions(
      "central",
    );
  ```

  ##### Get mapbox_id
  - From SuggestionResponse
  ```dart
  String mapboxId = searchPlace.suggestions[0].mapboxId;
  ```

  ##### Get Place Details
  ```dart
  ApiResponse<RetrieveResonse> searchPlace = await search.getPlace(mapboxId);
  ```



### Reverse GeoCoding
```dart
var reverseGeoCoding = GeoCoding(
    apiKey: 'API Key', // dont pass if you have set it in MapBoxSearch.init('API KEY')
    limit: 5,
);

Future<ApiResponse<List<MapBoxPlace>>> getAddress() =>
  reverseGeoCoding.getAddress(
    Location(lat: 72.0, lng: 76.00),
);
```



### Forward GeoCoding Search
```dart
var geocoding = GeoCoding(
    apiKey: 'API Key', // dont pass if you have set it in MapBoxSearch.init('API KEY')
    country: "BR",
    limit: 5,
    types: [PlaceType.address, PlaceType.place],
);

Future<ApiResponse<List<MapBoxPlace>>> getPlaces() =>
  geocoding.getPlaces(
      "central park",
      proximity: Location(
        lat: -19.984634,
        lng: -43.9502958,
      ),
    );
```

### Static Image
```dart
MapBoxStaticImage staticImage = MapBoxStaticImage(
    apiKey: 'API Key', // dont pass if you have set it in MapBoxSearch.init('API KEY')
  );
```

### Image With Polyline
```dart
    String getStaticImageWithPolyline() => staticImage.getStaticUrlWithPolyline(
      point1: Location(lat: 37.77343, lng: -122.46589),
      point2: Location(lat: 37.75965, lng: -122.42816),
      marker1: MapBoxMarker( markerColor: Colors.black, 
      markerLetter: MakiIcons.aerialway.value, 
      markerSize: MarkerSize.LARGE),
      marker2: MapBoxMarker(
          markerColor: Color.rgb(244, 67, 54),
          markerLetter: 'q',
          markerSize: MarkerSize.SMALL),
      height: 300,
      width: 600,
      zoomLevel: 16,
      style: MapBoxStyle.Mapbox_Dark,
      path: MapBoxPath(pathColor: Color.rgb(255, 0, 0), pathOpacity: 0.5,     pathWidth: 5),
      render2x: true);
``` 

### Image with Marker
```dart
String getStaticImageWithMarker() => staticImage.getStaticUrlWithMarker(
  center: Location(lat: 37.77343, lng: -122.46589),
  marker: MapBoxMarker(
      markerColor: Color.rgb(0, 0, 0), markerLetter: 'p', markerSize: MarkerSize.LARGE),
  height: 300,
  width: 600,
  zoomLevel: 16,
  style: MapBoxStyle.Mapbox_Streets,
  render2x: true,
);
```

### Image without Marker
```dart
String getStaticImageWithoutMarker() => staticImage.getStaticUrlWithoutMarker(
    center: Location(lat: 37.75965, lng: -122.42816),
    height: 300,
    width: 600,
    zoomLevel: 16,
    style: MapBoxStyle.Mapbox_Outdoors,
    render2x: true,
  );
```
# Screenshots

## Static Map Image

<img src="https://github.com/ketanchoyal/mapbox_search/raw/dev/Screenshots/staticImages.png" alt="Static Map Image"/>

