import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
import 'package:para_passenger/presentation/utils.dart';

class RoundedInformation extends StatefulWidget {
  RoundedInformation({Key? key, this.text}) : super(key: key);
  String? text;
  @override
  _RoundedInformationState createState() => _RoundedInformationState();
}

class _RoundedInformationState extends State<RoundedInformation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
          shadows: [
            BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Color.fromARGB(184, 0, 153, 140))
          ],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(width: 4, color: textColor)),
          color: Color.fromARGB(255, 69, 137, 139)),
      child: Text(
        widget.text != null ? widget.text! : "",
        style: defaultTextStyle.copyWith(fontSize: 16),
      ),
    );
  }
}
