// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../services/user_service.dart';
import 'package:shopping_application/values/route_value.dart';
import '../../values/text_style_value.dart';
import '../widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isError = false;
  String? error;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
                    style: TextStyleValue.h1,
                  ),
                  const SizedBox(height: 30),
                  TextFieldWidget(
                    controller: _emailController,
                    hintText: "Email",
                    isPasswordField: false,
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      _signIn();
                    },
                    child: Container(
                      height: size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyleValue.h4
                              .copyWith(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () async {
                          loginToSignUp();
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  if (_isError) ...[
                    const SizedBox(height: 10),
                    Text(
                      error!,
                      style: TextStyleValue.error,
                    )
                  ]
                ],
              ),
            ),
            if (_isLoading) ...[
              Container(
                color: Colors.white.withOpacity(0.4),
              ),
              const Center(child: CircularProgressIndicator())
            ]
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    String? email = _emailController.text;
    String? password = _passwordController.text;

    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        _isLoading = false;
        if (email != '' && password != '') {
          var result = await UserService.login(email, password);
          if (result != null) {
            Navigator.pushNamed(
              context,
              RouteValue.routeNameToHome,
              arguments: result.accessToken,
            );
          } else {
            error = "Email or password is not correct";
            _isError = true;
            setState(() {});
          }
        } else {
          setState(() {
            error = "Please enter complete information";
            _isError = true;
          });
        }
      },
    );
  }

  void loginToSignUp() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteValue.routeNameToSignUp,
          (route) => false,
        );
      },
    );
  }
}
