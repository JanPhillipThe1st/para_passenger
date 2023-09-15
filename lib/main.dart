import 'package:flutter/material.dart';
import 'package:para_passenger/business_logic/cubit/user_cubit.dart';
import 'package:para_passenger/presentation/pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        title: 'Para Passenger',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 22, 21, 20)),
          useMaterial3: true,
        ),
        home: Login(),
      ),
    );
  }
}
