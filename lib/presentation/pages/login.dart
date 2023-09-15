import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
import 'package:para_passenger/presentation/pages/home_screen.dart';
import 'package:para_passenger/presentation/pages/user_info.dart';
import 'package:para_passenger/presentation/utils.dart';
import 'package:para_passenger/presentation/widgets/para_emblem.dart';
import 'package:para_passenger/presentation/widgets/text_field_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController = TextEditingController(),
      _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = UserCubit();
    return Scaffold(
        backgroundColor: defaultColor,
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Login",
              style: TextStyle(
                  color: textColor, fontFamily: "Poppins", fontSize: 24),
            ),
          ),
          forceMaterialTransparency: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          color: defaultColor,
          child: ListView(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              emblem,
              TextFieldWidget(
                hinttext: "Username",
                controller: _usernameController,
                onchange: (username) {
                  context.read<UserCubit>().state.username = username;
                },
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              TextFieldWidget(
                hinttext: "Password",
                controller: _passwordController,
                obscured: true,
                onchange: (password) {
                  context.read<UserCubit>().state.password = password;
                },
              ),
              // StreamBuilder<UserState>(
              //   stream: userCubit.stream,
              //   builder: (context, snapshot) {
              //     return Text(snapshot.data == null
              //         ? "No Data"
              //         : snapshot.data!.username!);
              //   },
              // ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20)),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 15)),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: defaultTextStyle.copyWith(
                          color: Color.fromARGB(255, 14, 159, 179),
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2.5),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                    Icon(
                      Icons.login,
                      color: Color.fromARGB(255, 14, 159, 179),
                      weight: 10,
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Sign up",
                    style: defaultTextStyle.copyWith(
                        color: textColor,
                        decorationColor: textColor,
                        decoration: TextDecoration.underline),
                  ))
            ],
          ),
        ));
  }
}
