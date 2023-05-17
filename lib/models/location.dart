part of mapbox_search;

typedef Location = ({double long, double lat});

extension on Location {
  String get asString => '$long,$lat';

  List<double> get asList => [long, lat];
}

extension on List {
  Location get asLocation => (
        long: this[0] as double,
        lat: this[1] as double,
      );
}

sealed class Proximity {
  factory Proximity.LocationNone() => const _LocationNone();
  factory Proximity.LocationIp() => const _LocationIp();
  factory Proximity.Location(Location loc) => _Location(loc: loc);
  factory Proximity.LatLong({required double lat, required double long}) =>
      _Location(loc: (long: long, lat: lat));
}

/// A class that represents a location around which places will be searched.
class _Location implements Proximity {
  final Location loc;

  const _Location({
    required this.loc,
  });

  String get asString => loc.asString;
}

/// A class that represents that no location based search will be performed.
class _LocationNone implements Proximity {
  const _LocationNone();
}

/// A class that represents that the location will be based on the IP address of the user.
class _LocationIp implements Proximity {
  const _LocationIp();
}
