import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:para_passenger/data/models/routing.dart';
import 'package:para_passenger/presentation/utils.dart';
import 'package:para_passenger/presentation/widgets/rounded_information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _controller;

  TomTomRouting networkUtilTomTom = TomTomRouting();
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
                      onTap: () async {},
                      markerId:
                          MarkerId(context.read<UserCubit>().state.username!),
                      infoWindow: InfoWindow(
                          title: context.read<UserCubit>().state.username),
                      icon: BitmapDescriptor.defaultMarker,
                      position: LatLng(7.846547833953886, 123.43259318325657))
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedInformation(
                    text: context.read<UserCubit>().state.username,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  RoundedInformation(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      clipBehavior: Clip.hardEdge,
                      child: Image.network(
                        "https://firebasestorage.googleapis.com/v0/b/para-transportation.appspot.com/o/User%20Photos%2FIMG_20230914_130858.jpg?alt=media&token=c8724401-776b-4666-94a1-9deaf1a82eac",
                        height: 60,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  RoundedInformation(
                    text: "Dao, Pagadian City".substring(0, 10) + "...",
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
