import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
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
              IconButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(buttonColor())),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => UserInfo()));
                },
                icon: Icon(Icons.login),
              ),
            ],
          ),
        ));
  }
}
