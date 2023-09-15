import 'package:flutter/material.dart';
import 'package:para_passenger/presentation/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldWidget extends StatefulWidget {
  TextFieldWidget(
      {Key? key,
      this.hinttext,
      required this.controller,
      required this.onchange})
      : super(key: key);
  String? hinttext;
  TextEditingController controller;
  void Function(String) onchange;
  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: borderColor))),
        child: TextField(
          onChanged: widget.onchange,
          controller: widget.controller,
          style:
              TextStyle(fontFamily: "Poppins", fontSize: 14, color: textColor),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hinttext,
              hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  color: textColor.withAlpha(200))),
        ));
  }
}
