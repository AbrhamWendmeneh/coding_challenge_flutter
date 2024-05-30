import 'package:coding_challenge/models/directions.dart';
import 'package:dio/dio.dart';
import 'package:coding_challenge/.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';
  Dio _dio;

  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': google_api_key,
    });
    // if (response.data['status'] != 'OK') {
    //   throw Exception(response.data['error_message']);
    // }
    // return Directions.fromMap(response.data);
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    } else {
      throw Exception('Failed to load directions');
    }
  }
}
