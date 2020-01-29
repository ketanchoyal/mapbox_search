# mapbox_search

[![Pub](https://img.shields.io/pub/v/mapbox_search)](https://pub.dartlang.org/packages/mapbox_search) <a href="https://flutterawesome.com/a-flutter-package-for-place-search-using-mapbox-api-and-for-static-map-image/">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>

# MapBox Search 

This package provides easy api calls to MapBox Search API. 

Also, it contains an static map image generator 😆.

#Migration to 2.0
Before 2.0 this library depended on Flutter SDK, preventing its usage on other platforms such as a backend, CLI apps, Dart2Javascript, etc...

Now all the Flutter related code, such as the `MapBoxSearchWidget` was moved to a separated library, here: PUT_NEW_PACKAGE_URL_HERE.

## Installing

First of all you must acquire an API key on the MapBox website https://www.mapbox.com/

Then, add the following to your `pubspec.yaml` file:

    dependencies:
      mapbox_search: any

# Example

### Reverse GeoCoding
    var reverseGeoCoding = ReverseGeoCoding(
        apiKey: 'API Key',
        limit: 5,
    );

    Future<List<MapBoxPlace>> getPlaces() =>
      reverseGeoCoding.getAddress(
        Location(lat: 72.0, lng: 76.00),
    );
    
### Places Seach
    var placesSearch = PlacesSearch(
        apiKey: 'API Key',
        limit: 5,
    );

    Future<List<MapBoxPlace>> getPlaces() =>
      placesSearch.getPlaces("New York");


### Static Image
    MapBoxStaticImage staticImage = MapBoxStaticImage(
        apiKey:
            "API Key");

### Image With Polyline
    String getStaticImageWithPolyline() => staticImage.getStaticUrlWithPolyline(
      point1: Location(lat: 37.77343, lng: -122.46589),
      point2: Location(lat: 37.75965, lng: -122.42816),
      marker1: MapBoxMarker( markerColor: Colors.black, markerLetter: 'p', markerSize: MarkerSize.LARGE),
      msrker2: MapBoxMarker(
          markerColor: Colors.redAccent,
          markerLetter: 'q',
          markerSize: MarkerSize.SMALL),
      height: 300,
      width: 600,
      zoomLevel: 16,
      style: MapBoxStyle.Mapbox_Dark,
      path: MapBoxPath(pathColor: Colors.red, pathOpacity: 0.5,     pathWidth: 5),
      render2x: true);
    

### Image with Marker
    String getStaticImageWithMarker() => staticImage.getStaticUrlWithMarker(
      center: Location(lat: 37.77343, lng: -122.46589),
      marker: MapBoxMarker(
          markerColor: Colors.black, markerLetter: 'p', markerSize: MarkerSize.LARGE),
      height: 300,
      width: 600,
      zoomLevel: 16,
      style: MapBoxStyle.Mapbox_Streets,
      render2x: true,
    );
  

### Image without Marker
    String getStaticImageWithoutMarker() => staticImage.getStaticUrlWithoutMarker(
        center: Location(lat: 37.75965, lng: -122.42816),
        height: 300,
        width: 600,
        zoomLevel: 16,
        style: MapBoxStyle.Mapbox_Outdoors,
        render2x: true,
      );


# Screenshots

## Static Map Image

<img src="https://github.com/ketanchoyal/mapbox_search/raw/dev/Screenshots/staticImages.png" alt="Static Map Image"/>

## Search Widget

<img src="https://github.com/ketanchoyal/mapbox_search/raw/dev/Screenshots/search2.png" alt="Demo"/>

<img src="https://github.com/ketanchoyal/mapbox_search/raw/dev/Screenshots/search1.png" alt="Demo"/>