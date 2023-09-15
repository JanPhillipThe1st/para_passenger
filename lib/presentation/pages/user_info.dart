import 'package:flutter/material.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Text(context.read<UserCubit>().state.username != null
              ? context.read<UserCubit>().state.username!
              : "No data")
        ],
      ),
    );
  }
}
