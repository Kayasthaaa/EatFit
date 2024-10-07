// ignore_for_file: library_private_types_in_public_api, unused_element, avoid_print

import 'dart:async';

import 'package:eat_fit/src/instructor/constant/toaster.dart';
import 'package:eat_fit/src/instructor/feature/widgets/app_texts.dart';
import 'package:eat_fit/src/instructor/feature/widgets/containers.dart';
import 'package:eat_fit/src/user/feature/screen/payment/screen/payment_screen.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_invitation/models/user_invitations_models.dart';
import 'package:eat_fit/src/user/feature/screen/user_meal_plan_details/models/user_meal_details_models.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class GoogleMapsPage extends StatefulWidget {
  final UserMealDetailsModels models;
  final UserInvitationsModels inv;
  const GoogleMapsPage({super.key, required this.models, required this.inv});

  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final navCont = PersistentTabController(initialIndex: 0);
  final Set<Marker> _markers = {};
  final TextEditingController _searchController = TextEditingController();
  String _searchAddress = '';
  bool _currentLocationSet = false;
  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  void _requestLocationPermission() async {
    final PermissionStatus permissionStatus =
        await Permission.location.request();
    if (permissionStatus != PermissionStatus.granted) {
    } else {
      _getCurrentLocation();
    }
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        _markers.add(Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'Current Location'),
        ));
      });

      CameraPosition initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      );

      GoogleMapController controller = await _controller.future;
      controller
          .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
    } catch (e) {
      ToasterService.error(message: 'Cannot get location, provide more info');
    }
  }

  void _searchLocation(String searchQuery) async {
    try {
      if (!searchQuery.toLowerCase().contains('nepal')) {
        searchQuery +=
            ', Nepal'; // Automatically append 'Nepal' to the search query
      }

      List<Location> locations = await locationFromAddress(searchQuery);

      if (locations.isNotEmpty) {
        setState(() {
          _markers.clear(); // Clear existing markers
          _currentLocationSet = false; // Reset flag when new search is made
        });

        // Check if current location marker is set
        if (_markers
            .any((marker) => marker.markerId.value == 'current_location')) {
          Location nearestLocation = _findNearestLocation(locations);

          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(nearestLocation.toString()),
              position:
                  LatLng(nearestLocation.latitude, nearestLocation.longitude),
              infoWindow: InfoWindow(title: searchQuery),
            ));
            _searchAddress = searchQuery;
          });

          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(nearestLocation.latitude, nearestLocation.longitude),
              13.0));
        } else {
          // If current location marker is not set, simply add the searched location
          Location firstLocation = locations.first;

          setState(() {
            _markers.add(Marker(
              markerId: MarkerId(firstLocation.toString()),
              position: LatLng(firstLocation.latitude, firstLocation.longitude),
              infoWindow: InfoWindow(title: searchQuery),
            ));
            _searchAddress = searchQuery;
          });

          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newLatLngZoom(
              LatLng(firstLocation.latitude, firstLocation.longitude), 13.0));
        }
      } else {
        ToasterService.error(message: 'No locations found for $searchQuery');
      }
    } catch (e) {
      ToasterService.error(
          message: 'Error searching location, please try again');
    }
  }

  Location _findNearestLocation(List<Location> locations) {
    if (_currentLocationSet) {
      // Check if current location marker is set
      LatLng currentPosition = _markers
          .where((marker) => marker.markerId.value == 'current_location')
          .first
          .position;

      Location nearestLocation = locations.reduce((curr, next) {
        double currDistance = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            curr.latitude,
            curr.longitude);
        double nextDistance = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            next.latitude,
            next.longitude);
        return currDistance < nextDistance ? curr : next;
      });

      return nearestLocation;
    } else {
      _currentLocationSet =
          true; // Set flag when current location marker is set
      return locations.first;
    }
  }

  void _getCurrentLocationAndMoveCamera() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      setState(() {
        _markers.clear();
        _markers.add(Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'Current Location'),
        ));
      });

      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude), 15.0));
    } catch (e) {
      ToasterService.error(message: 'Cannot get location, provide more info');
    }
  }

  void _textsButtonPressed() {
    if (_markers.isNotEmpty) {
      Marker selectedMarker = _markers.first;
      LatLng selectedPosition = selectedMarker.position;
      PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: PaymentScreen(
          models: widget.models,
          inv: widget.inv,
        ),
        withNavBar: true,
      );
      print(
          'Latitude: ${selectedPosition.latitude}, Longitude: ${selectedPosition.longitude}');
    }
  }

  void _myLocationButtonPressed() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      setState(() {
        _markers.add(Marker(
          markerId: const MarkerId('current_location'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'Current Location'),
        ));
      });

      GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude), 15.0));

      // Display the current location's address in the container
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      String? currentAddress =
          placemarks.isNotEmpty ? placemarks[0].name : 'Unknown';
      setState(() {
        _searchAddress = currentAddress!;
      });
    } catch (e) {
      ToasterService.error(message: 'Cannot get location, provide more info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(28.3949, 84.1240), // Centered at Nepal
                zoom: 9.0,
              ),
              markers: _markers,
              mapType: _currentMapType, // Set the map type
            ),
          ),
          Positioned(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            child: SafeArea(
              child: Row(
                children: [
                  Containers(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    width: 50,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 2.0),
                        ),
                      ],
                    ),
                    child: const Center(child: Icon(Icons.arrow_back)),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 22),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: const InputDecoration(
                                hintText: 'Search for a location',
                                border: InputBorder.none,
                              ),
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  _searchLocation(value);
                                }
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              String searchQuery =
                                  _searchController.text.trim();
                              if (searchQuery.isNotEmpty) {
                                _searchLocation(searchQuery);
                              }
                            },
                          ),
                          PopupMenuButton<MapType>(
                            icon: const Icon(Icons.filter_list),
                            onSelected: (MapType result) {
                              setState(() {
                                _currentMapType = result;
                              });
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<MapType>>[
                              const PopupMenuItem<MapType>(
                                value: MapType.normal,
                                child: Text('Normal'),
                              ),
                              const PopupMenuItem<MapType>(
                                value: MapType.hybrid,
                                child: Text('Hybrid'),
                              ),
                              const PopupMenuItem<MapType>(
                                value: MapType.satellite,
                                child: Text('Satellite'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_searchAddress.isNotEmpty)
            Positioned(
              bottom: 10.0,
              left: 10.0,
              right: 10.0,
              child: SafeArea(
                child: Row(
                  children: [
                    Containers(
                      onTap: _textsButtonPressed,
                      height: 38,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Texts(
                          overflow: TextOverflow.ellipsis,
                          texts: 'Set this Location',
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Texts(
                          overflow: TextOverflow.ellipsis,
                          texts: 'Your address: $_searchAddress',
                          textAlign: TextAlign.start,
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
            bottom: 60.0,
            right: 16.0,
            child: SafeArea(
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: _myLocationButtonPressed,
                child: const Icon(Icons.location_searching),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
