import 'dart:convert';
import 'dart:ffi';

import 'package:bengkel_mekanik/constant/colors.dart';
import 'package:bengkel_mekanik/constant/form_messages.dart';
import 'package:bengkel_mekanik/page/lupa_pass.dart';
import 'package:bengkel_mekanik/page/register.dart';
import 'package:bengkel_mekanik/page/utama.dart';
import 'package:bengkel_mekanik/widget/custom_button.dart';
import 'package:bengkel_mekanik/widget/custom_circle.dart';
import 'package:bengkel_mekanik/widget/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginMekanik extends StatefulWidget {
  const LoginMekanik({super.key});

  @override
  State<LoginMekanik> createState() => _LoginMekanikState();
}

class _LoginMekanikState extends State<LoginMekanik> {
  final _formKey = GlobalKey<FormState>();
  final _emailFormFieldKey = GlobalKey<FormState>();
  final _passwordFormFieldKey = GlobalKey<FormState>();
  String? email = '', password = '';
  String paswordFieldSuffixText = "Tampilkan";
  late FocusNode passwordFocusNode;
  bool _obscureText = true;
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passControl = new TextEditingController();

  _signIn() async {
    Fluttertoast.showToast(
        msg: "Mohon Tunggu...",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
    final response = await http.post(
        Uri.parse("http://mekanik-mks.balconteach.my.id/loginmekanik"),
        body: {"email": _emailControl.text, "password": _passControl.text});
    print(_emailControl.text);
    final data = jsonDecode(response.body);
    String stat = data['status'];
    Fluttertoast.showToast(
        msg: data['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.white,
        fontSize: 16.0);
    if (stat == "OK") {
      _simpanLogin(data['id_mekanik_login']).whenComplete(() =>
          Navigator.pushNamedAndRemoveUntil(
              context, UtamaScreen.routeName, (route) => false));
    } else {}
  }

  Future _simpanLogin(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('mekanik_login', id);
  }

  @override
  void initState() {
    // TODO: implement initState
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [loginAtas(context), loginBawah()],
        )),
      ),
    );
  }

  Padding loginBawah() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                emailFormField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                passwordFormField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: InkWell(
                //     onTap: () => Navigator.push(
                //         context,
                //         CustomScaleTransition(
                //             nextPageUrl: ForgotPasswordScreen.routeName,
                //             nextPage: const ForgotPasswordScreen())),
                //     child: const Text(
                //       "Forgot Password?",
                //       style: TextStyle(
                //           color: primaryColor,
                //           decoration: TextDecoration.underline,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomButton(
                    title: "Login",
                    backgroundColor: primaryColor,
                    forgroundColor: Colors.white,
                    width: MediaQuery.of(context).size.width * 0.85,
                    onPressed: () => _signIn()),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  TextFormField emailFormField() {
    return TextFormField(
      controller: _emailControl,
      key: _emailFormFieldKey,
      onSaved: (newEmail) {
        setState(() {
          email = newEmail;
        });
      },
      // onChanged: (newEmail) {
      //   _emailFormFieldKey.currentState!
      //       .validate(); // call emailFormField validator
      // },
      onFieldSubmitted: (newEmail) {
        passwordFocusNode.requestFocus();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
          labelText: "Email", hintText: "Masukkan Email Anda"),
      // validator: (newEmail) {
      //   if (newEmail!.isEmpty) {
      //     return kEmailNullError;
      //   } else if (!emailValidatorRegExp.hasMatch(newEmail)) {
      //     return kInvalidEmailError;
      //   }
      //   return null;
      // },
    );
  }

  TextFormField passwordFormField() {
    return TextFormField(
      controller: _passControl,
      key: _passwordFormFieldKey,
      focusNode: passwordFocusNode,
      onSaved: (newPassword) {
        setState(() {
          password = newPassword;
        });
      },
      // onChanged: (newPassword) {
      //   _passwordFormFieldKey.currentState!
      //       .validate(); // call passowrd field validator
      // },
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      decoration: InputDecoration(
          labelText: "Password",
          hintText: "Masukkan Password Anda",
          suffixIcon: TextButton(
            child: Text(
              paswordFieldSuffixText,
              style: const TextStyle(color: primaryColor),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
                paswordFieldSuffixText = (paswordFieldSuffixText == "Tampilkan")
                    ? "Sembunyikan"
                    : "Tampilkan";
              });
            },
          )),
      // validator: (newPassword) {
      //   if (newPassword!.isEmpty) {
      //     return kPasswordNullError;
      //   } else if (newPassword.length < 8) {
      //     return kShortPasswordError;
      //   }
      //   return null;
      // },
    );
  }

  Container loginAtas(BuildContext ctx) {
    var size = MediaQuery.of(ctx).size;
    return Container(
      color: primaryColor,
      height: size.height * 0.3,
      child: Stack(
        children: [
          Positioned(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.25,
              child: const CustomCircle(
                width: 25,
                height: 25,
                color: primaryColor,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.065,
              right: MediaQuery.of(context).size.width * 0.03,
              child: const CustomCircle(
                width: 125,
                height: 125,
                gradient: circleGradientColor,
                color: circleColor,
                borderWidth: 2,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "Selamat\nDatang",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 55,
                  color: Colors.white),
            ),
          ),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.06,
              right: MediaQuery.of(context).size.width * 0.18,
              child: const CustomCircle(
                width: 35,
                height: 35,
                color: primaryColor,
                borderWidth: 4,
              )),
        ],
      ),
    );
  }
}
