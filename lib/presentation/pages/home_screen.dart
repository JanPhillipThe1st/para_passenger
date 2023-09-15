import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:para_passenger/presentation/utils.dart';
import 'package:para_passenger/presentation/widgets/rounded_information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Container(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    zoom: 15,
                    target: LatLng(7.846547833953886, 123.43259318325657)),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                markers: {
                  Marker(
                      markerId:
                          MarkerId(context.read<UserCubit>().state.username!),
                      infoWindow: InfoWindow(title: "Don't zoom in lol"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(7.846547833953886, 123.43259318325657))
                },
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedInformation(
                    text: context.read<UserCubit>().state.username,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
