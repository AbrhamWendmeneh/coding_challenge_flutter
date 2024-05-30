import 'package:coding_challenge/models/directions.dart';
import 'package:coding_challenge/repository/directions_repository.dart';
import 'package:coding_challenge/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const intialCameraPosition = CameraPosition(
    target: LatLng(9.005401, 38.76361),
    zoom: 10,
  );

  GoogleMapController? mapController;
  Marker? originMarker;
  Marker? destinationMarker;
  Directions? info;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          actions: [
            if (originMarker != null)
              TextButton(
                onPressed: () => mapController!.animateCamera(
                  info != null
                      ? CameraUpdate.newLatLngBounds(info!.bounds, 100.0)
                      : CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: originMarker!.position,
                            zoom: 14,
                            tilt: 50.0,
                          ),
                        ),
                ),
                child: const Text('Origin'),
              ),
            if (destinationMarker != null)
              TextButton(
                onPressed: () => mapController!.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: destinationMarker!.position,
                      zoom: 14,
                      tilt: 50.0,
                    ),
                  ),
                ),
                child: const Text('Destination'),
              ),
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: intialCameraPosition,
              onMapCreated: (controller) => mapController = controller,
              markers: {
                if (originMarker != null) originMarker!,
                if (destinationMarker != null) destinationMarker!,
              },
              polylines: {
                if (info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: kColorRed,
                    width: 5,
                    points: info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
              onLongPress: _addMarker,
            ),
            if (info != null)
              Positioned(
                top: 20.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Text(
                    '${info!.totalDistance}, ${info!.totalDuration}',
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: kColorBlue),
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            mapController?.animateCamera(
              CameraUpdate.newCameraPosition(intialCameraPosition),
            );
          },
          child: const Icon(Icons.center_focus_strong),
        ));
  }

  void _addMarker(LatLng pos) async {
    if (originMarker == null ||
        (originMarker != null && destinationMarker != null)) {
      setState(() {
        originMarker = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        destinationMarker = null;
        info = null;
      });
    } else {
      setState(() {
        destinationMarker = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
      });

      final directions = await DirectionsRepository().getDirections(
        origin: originMarker!.position,
        destination: destinationMarker!.position,
      );
      debugPrint(directions.totalDistance);

      setState(() {
        info = directions;
      });
    }
  }
}
