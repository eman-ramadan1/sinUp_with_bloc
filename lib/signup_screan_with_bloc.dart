import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sin_up_with_bloc/bloc/signup_bloc.dart';
import 'package:sin_up_with_bloc/sin_up_valdation/confirmPaswordValidation.dart';
import 'package:sin_up_with_bloc/sin_up_valdation/emailValidation.dart';
import 'package:sin_up_with_bloc/sin_up_valdation/passwordValidation.dart';

class SignUpScreenWithBloc extends StatefulWidget {
  const SignUpScreenWithBloc({super.key});

  @override
  State<SignUpScreenWithBloc> createState() => _SignUpScreenWithBlocState();
}

class _SignUpScreenWithBlocState extends State<SignUpScreenWithBloc> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc()..add(InitiSingUpScreenEvent()),
      child: Scaffold(
        
        appBar: AppBar(title: const Text("Sign Up"),
        backgroundColor: Colors.green,),
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailure) {
              Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
            }

            if (state is SignUpSuccess) {
              Fluttertoast.showToast(
                msg: "Sign up successful! Welcome",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.green,
                textColor: Colors.white,
              );
            }
          },
          builder: (context, state) {
            if (state is SignUpInitial || state is SignUpFailure) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  autovalidateMode: AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: emailValidation(context: context),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: PasswordValidation(context: context),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                        validator: (value) {
                          return ConfirmPasswordValidation(
                            context: context,
                            passwordController: _passwordController,
                          )(value);
                        },
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(
                                    SignUpSubmittedEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      confirmPassword: _confirmPasswordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
