import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class MapCommands {
  Future<void> commandMap() async {
    var uri = Uri.parse(
        "google.navigation:q=7.846547833953886,123.43259318325657&mode=d");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
