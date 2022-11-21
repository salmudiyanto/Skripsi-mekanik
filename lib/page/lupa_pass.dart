import 'package:bengkel_mekanik/constant/colors.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = "/forgot_password";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      // body: const ForgotPasswordBody(),
      body: SafeArea(
        child: SingleChildScrollView(),
      ),
    );
  }
}
