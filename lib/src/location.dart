part of mapbox_search;

abstract class Proximity {}

/// A class that represents a location around which places will be searched.
class Location implements Proximity {
  final double lat;
  final double lng;

  const Location({
    required this.lat,
    required this.lng,
  });

  String get asString => '$lng,$lat';
}

/// A class that represents that no location based search will be performed.
class LocationNone implements Proximity {
  const LocationNone();
}

/// A class that represents that the location will be based on the IP address of the user.
class LocationIp implements Proximity {
  const LocationIp();
}
