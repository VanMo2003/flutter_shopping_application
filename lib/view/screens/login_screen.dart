// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../controllers/loading_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/loading_model.dart';
import '../../values/text_style_value.dart';
import '../widgets/text_field_widget.dart';
import 'package:momentum/momentum.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

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
                      Momentum.controller<UserController>(context).login(
                          context,
                          _emailController.text,
                          _passwordController.text);
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
                        onTap: () async {},
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
            MomentumBuilder(
              controllers: const [LoadingController],
              builder: (context, snapshots) {
                var isLoading = snapshots<LoadingModel>().isLoading;
                if (isLoading ?? false) {
                  return Container(
                    color: Colors.white.withOpacity(0.4),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
