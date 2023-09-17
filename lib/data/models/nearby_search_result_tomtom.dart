import 'package:flutter/material.dart';

class NearbySearchResult {
  Summary? summary = Summary();
  List<Result>? results = [];
  NearbySearchResult({this.summary, this.results});
  factory NearbySearchResult.fromJSON(Map<String, dynamic> json) {
    return NearbySearchResult(
      summary: Summary.fromJSON(json["summary"]),
    );
  }
}

class Summary {
  String? queryType = "NEARBY";
  int? queryTime = 0;
  int? numResults = 0;
  int? offset = 0;
  int? totalResults = 0;
  int? fuzzyLevel = 0;
  String? geobiasCountry = "";
  GeoBias? geoBias = GeoBias();
  Summary(
      {this.queryType,
      this.queryTime,
      this.numResults,
      this.offset,
      this.totalResults,
      this.fuzzyLevel,
      this.geobiasCountry,
      this.geoBias});
  factory Summary.fromJSON(Map<String, dynamic> json) {
    return Summary(
      queryType: json["queryType"],
      queryTime: json["queryTime"],
      numResults: json["numResults"],
      offset: json["offset"],
      totalResults: json["totalResults"],
      fuzzyLevel: json["fuzzyLevel"],
      geobiasCountry: json["geobiasCountry"],
      geoBias: GeoBias.fromJSON(json["geoBias"]),
    );
  }
}

class GeoBias {
  double? lat = 0.00;
  double? lon = 0.00;
  GeoBias({this.lat, this.lon});
  factory GeoBias.fromJSON(Map<String, dynamic> json) {
    return GeoBias(lat: json["lat"], lon: json["lon"]);
  }
}

class Result {
  String type = "";
  String id = "";
  double score = 0.00;
  double dist = 0.00;
  String info = "";
  POI poi = POI();
  POIAddress address = POIAddress();
  POIPosition poiPosition = POIPosition();
  POIViewPort poiViewPort = POIViewPort();
  List<POIEntryPoint> entryPoints = [];
  DataSources dataSources = DataSources();
}

class POI {
  String name = "";
  String phone = "";
  List<CategorySet> categorySet = [];
  List<String> categories = [];
  List<POIClassification> classifications = [];
}

class CategorySet {
  int? id = 0;
  CategorySet({this.id});
}

class POIClassification {
  String code = "";
}

class POIName {
  String? nameLocale = "";
  String? name = "";
  POIName({this.name, this.nameLocale});
}

class POIAddress {
  String streetName = "";
  String municipalitySubdivision = "";
  String municipality = "";
  String countrySecondarySubdivision = "";
  String countrySubdivision = "";
  String postalCode = "";
  String countryCode = "";
  String country = "";
  String countryCodeISO3 = "";
  String freeformAddress = "";
  String localName = "";
}

class POIPosition {
  double? lat = 0.00;
  double? lon = 0.00;
  POIPosition({this.lat, this.lon});
}

class Coordinates {
  double? lat = 0.00;
  double? lon = 0.00;
  Coordinates({this.lat, this.lon});
}

class POIViewPort {
  Coordinates topLeftPoint = Coordinates();
  Coordinates btmRightPoint = Coordinates();
}

class POIEntryPoint {
  String type = "";
  Coordinates position = Coordinates();
}

class DataSources {
  Geometry geometry = Geometry();
}

class Geometry {
  String id = "";
}
