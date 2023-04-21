[![Pub](https://img.shields.io/pub/v/mapbox_search)](https://pub.dev/packages/mapbox_search) 
# About

This package provides easy api calls to MapBox Search API. 

Also, it contains an static map image generator 😆.

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

# Examples

### Reverse GeoCoding
```dart
var reverseGeoCoding = ReverseGeoCoding(
    apiKey: 'API Key',
    limit: 5,
);

Future<List<MapBoxPlace>> geAddress() =>
  reverseGeoCoding.getAddress(
    Location(lat: 72.0, lng: 76.00),
);
```
    
### Places Seach
```dart
var placesSearch = PlacesSearch(
    apiKey: 'API Key',
    limit: 5,
);

Future<List<MapBoxPlace>> getPlaces() =>
  placesSearch.getPlaces("New York");
```

### Static Image
```dart
MapBoxStaticImage staticImage = MapBoxStaticImage(
    apiKey:
        "API Key");
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

## Search Widget

<img src="https://github.com/ketanchoyal/mapbox_search/raw/dev/Screenshots/search2.png" alt="Demo"/>

<img src="https://github.com/ketanchoyal/mapbox_search/raw/dev/Screenshots/search1.png" alt="Demo"/>
