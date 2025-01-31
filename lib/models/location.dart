import 'package:json_annotation/json_annotation.dart';

typedef Location = ({double long, double lat});

class LocationConverter extends JsonConverter<Location, List<dynamic>> {
  const LocationConverter() : super();

  @override
  Location fromJson(List<dynamic> json) {
    return (long: json[0] as double, lat: json[1] as double);
  }

  @override
  List<double> toJson(Location object) {
    return object.asList;
  }
}

class OptionalLocationConverter
    extends JsonConverter<Location?, List<dynamic>?> {
  const OptionalLocationConverter() : super();

  @override
  Location? fromJson(List<dynamic>? json) {
    return json == null
        ? null
        : (long: json[0] as double, lat: json[1] as double);
  }

  @override
  List<double>? toJson(Location? object) {
    return object == null ? null : object.asList;
  }
}

extension LocationAsList on Location {
  String get asString => '$long,$lat';

  List<double> get asList => [long, lat];
}

extension DoubleListToLocation on List<double> {
  Location get asLocation => (
        long: this[0],
        lat: this[1],
      );
}

sealed class Proximity {
  factory Proximity.LocationNone() => const NoProximity();
  factory Proximity.LocationIp() => const IpProximity();
  factory Proximity.Location(Location loc) => LocationProximity(loc: loc);
  factory Proximity.LatLong({required double lat, required double long}) =>
      LocationProximity(loc: (long: long, lat: lat));
}

/// A class that represents a location around which places will be searched.
class LocationProximity implements Proximity {
  final Location loc;

  const LocationProximity({
    required this.loc,
  });

  String get asString => loc.asString;
}

/// A class that represents that no location based search will be performed.
class NoProximity implements Proximity {
  const NoProximity();
}

/// A class that represents that the location will be based on the IP address of the user.
class IpProximity implements Proximity {
  const IpProximity();

  String get asString => 'ip';
}

class Coordinates {
  Coordinates({
    required this.location,
    required this.roundablePoints,
  });

  final Location location;
  final List<RoundablePoint>? roundablePoints;

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        location: (
          long: json['longitude'] as double,
          lat: json['latitude'] as double
        ),
        roundablePoints: (json['roundable_point'] as List<dynamic>?)
            ?.map((e) => RoundablePoint.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'longitude': location.long,
        'latitude': location.lat,
        'roundable_point': roundablePoints?.map((e) => e.toJson()).toList(),
      };
}

class RoundablePoint {
  RoundablePoint({
    required this.location,
    required this.name,
  });

  final Location location;
  final String name;

  factory RoundablePoint.fromJson(Map<String, dynamic> json) => RoundablePoint(
        location: (
          long: json['longitude'] as double,
          lat: json['latitude'] as double
        ),
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'longitude': location.long,
        'latitude': location.lat,
        'name': name,
      };
}

class OptionalCoordinatesConverter
    extends JsonConverter<Coordinates?, Map<String, dynamic>?> {
  const OptionalCoordinatesConverter() : super();

  @override
  Coordinates? fromJson(Map<String, dynamic>? json) {
    return json == null ? null : Coordinates.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Coordinates? object) {
    return object == null ? null : object.toJson();
  }
}
