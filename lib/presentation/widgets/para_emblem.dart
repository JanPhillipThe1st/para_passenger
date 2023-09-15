import 'package:flutter/material.dart';
import 'package:para_passenger/presentation/utils.dart';

const emblem = Column(
  children: [
    Image(
      image: AssetImage("lib/assets/icons/man.png"),
      height: 150,
    ),
    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
    Text(
      "Para Passenger",
      style: TextStyle(color: textColor, fontFamily: "Poppins"),
    ),
    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
  ],
);
