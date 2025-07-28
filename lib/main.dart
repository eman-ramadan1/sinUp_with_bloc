import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sin_up_with_bloc/bloc/signup_bloc.dart';
import 'package:sin_up_with_bloc/signup_screan_with_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUpScreenWithBloc (), 
      ),
    );
  }
}

