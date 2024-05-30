import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Directions {
  final LatLngBounds bounds;
  final String totalDistance;
  final String totalDuration;
  final List<PointLatLng> polylinePoints;

  Directions({
    required this.bounds,
    required this.totalDistance,
    required this.totalDuration,
    required this.polylinePoints,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    return Directions(
      bounds: LatLngBounds(
        southwest: LatLng(
          map['bounds']['southwest']['latitude'],
          map['bounds']['southwest']['longitude'],
        ),
        northeast: LatLng(
          map['bounds']['northeast']['latitude'],
          map['bounds']['northeast']['longitude'],
        ),
      ),
      totalDistance: map['totalDistance'],
      totalDuration: map['totalDuration'],
      polylinePoints: PolylinePoints().decodePolyline(map['polyline']),
    );
  }
}
