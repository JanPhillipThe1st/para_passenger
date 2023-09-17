import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:para_passenger/data/models/nearby_search_result_tomtom.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class NearbySearch {
  Future<NearbySearchResult> tomTomNearbySearch(double lat, double lon) async {
    NearbySearchResult nearbySearchResult = NearbySearchResult();
    final response = await http
        .get(TomTomRequestData(lat: lat, lon: lon).buildNetworkRequest());

    if (response.statusCode == 200) {
      nearbySearchResult =
          NearbySearchResult.fromJSON(jsonDecode(response.body));
    }
    return nearbySearchResult;
  }

  Future<Map<String, dynamic>> tomTomNearbySearchAsJSON(
      double lat, double lon) async {
    NearbySearchResult nearbySearchResult = NearbySearchResult();
    final response = await http
        .get(TomTomRequestData(lat: lat, lon: lon).buildNetworkRequest());
    print(TomTomRequestData(lat: lat, lon: lon).buildNetworkRequest());
    print(response.body);
    if (response.statusCode == 200) {
      nearbySearchResult =
          NearbySearchResult.fromJSON(jsonDecode(response.body));
    }
    return jsonDecode(response.body);
  }
}

class TomTomRequestData {
  double? lat = 0.0;
  double? lon = 0.0;
  String? tomTomHost = "https://api.tomtom.com/search/2/nearbySearch/.json?";
  TomTomRequestData({this.lat, this.lon});

  Uri buildNetworkRequest() {
    return Uri.parse(
        tomTomHost! + "key=ZwMsPrLjOCvB29QOSLT1Utv0q8QFljMI&lat=$lat&lon=$lon");
  }
}
