import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
import 'package:para_passenger/data/models/nearby_search_result_tomtom.dart';
import 'package:para_passenger/data/repository/nearby_search.dart';
import 'package:para_passenger/presentation/widgets/text_field_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:para_passenger/data/models/routing.dart';
import 'package:geolocator/geolocator.dart';
import 'package:para_passenger/presentation/utils.dart';
import 'package:para_passenger/presentation/widgets/rounded_information.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Marker? _passengerOrigin;
  Completer<GoogleMapController> _controller = Completer();
  TomTomRouting networkUtilTomTom = TomTomRouting();
  List<Map<String, dynamic>> addresses = [];
  Position? currentLocation;
  NearbySearchResult searchNearbyResponse = NearbySearchResult();
  Future<void> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition().then((value) async {
      currentLocation = value;
      Map<String, dynamic> poi = await NearbySearch()
          .tomTomNearbySearchAsJSON(value.latitude, value.longitude);
      for (Map<String, dynamic> result in poi["results"]) {
        addresses.add(result["poi"]);
      }
      setState(() {});
      _passengerOrigin = Marker(
          markerId: MarkerId(context.read<UserCubit>().state.username!),
          infoWindow: InfoWindow(
              title: context.read<UserCubit>().state.username!,
              snippet: "Dao, Pagadian City"),
          position: LatLng(value.latitude, value.longitude));
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Container(
              child: StreamBuilder<Position>(
                  stream: Geolocator.getPositionStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      print(snapshot.data);
                      return GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                            zoom: 15,
                            target:
                                LatLng(7.846547833953886, 123.43259318325657)),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        markers: {
                          Marker(
                            markerId: _passengerOrigin!.markerId,
                            infoWindow: _passengerOrigin!.infoWindow,
                            position: LatLng(snapshot.data!.latitude,
                                snapshot.data!.longitude),
                          )
                        },
                      );
                    }
                  }),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              maxChildSize: 0.6,
              minChildSize: .1,
              snap: true,
              snapSizes: [
                0.3,
              ],
              initialChildSize: 0.1,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return ListView(
                  controller: scrollController,
                  children: [
                    Container(
                      decoration: ShapeDecoration(
                        shadows: [BoxShadow()],
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50)),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          width: 50,
                          height: 2.5,
                          decoration: ShapeDecoration(
                            color: const Color.fromARGB(255, 105, 105, 105),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: TextFieldWidget(
                          hinttext: "Search for destination...",
                          color: Colors.white,
                          textColor: Colors.black,
                          hintTextColor: Colors.grey,
                          controller: TextEditingController(),
                          onchange: (value) {}),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Top Destinations",
                              style: defaultTextStyle.copyWith(
                                  color: Colors.black),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4)),
                            Icon(
                              Icons.location_pin,
                              size: 30,
                              color: Colors.red,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: EdgeInsets.only(bottom: 100),
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: addresses.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: ShapeDecoration(
                                        shadows: [
                                          BoxShadow(
                                              color: Color.fromARGB(
                                                  255, 22, 30, 37),
                                              offset: Offset(0, 0),
                                              blurRadius: 2)
                                        ],
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(
                                                  222, 120, 255, 244),
                                              Color.fromARGB(222, 112, 87, 255),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight)),
                                    padding: EdgeInsets.all(4),
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "lib/assets/icons/d70.jpg",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5)),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      addresses[index]["name"].toString(),
                                      style: defaultTextStyle.copyWith(
                                          color: Colors.black87, fontSize: 10),
                                      softWrap: true,
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5)),
                                  Container(
                                    decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        color: Colors.blue),
                                    child: TextButton(
                                      onPressed: () {},
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "GO",
                                            style: defaultTextStyle.copyWith(
                                                fontSize: 10),
                                          ),
                                          Icon(
                                            Icons.arrow_right,
                                            color: textColor,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
