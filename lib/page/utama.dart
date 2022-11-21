import 'package:bengkel_mekanik/constant/colors.dart';
import 'package:bengkel_mekanik/page/akun.dart';
import 'package:bengkel_mekanik/page/login.dart';
import 'package:bengkel_mekanik/widget/appbar.dart';
import 'package:bengkel_mekanik/widget/profile_menu.dart';
import 'package:flutter/material.dart';

class UtamaScreen extends StatefulWidget {
  const UtamaScreen({super.key});
  static const String routeName = "/utama";

  @override
  State<UtamaScreen> createState() => _UtamaScreenState();
}

class _UtamaScreenState extends State<UtamaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Mekanik"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.message))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            // const ProfilePicture(),
            const SizedBox(
              height: 20,
            ),
            ProfileMenu(
                text: "Akun Saya",
                icon: const Icon(
                  Icons.supervised_user_circle,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AkunSaya()));
                }),
            ProfileMenu(
              text: "Orderan Saya",
              icon: const Icon(Icons.supervised_user_circle),
              onPressed: () {},
            ),
            ProfileMenu(
              text: "Pengaturan",
              icon: const Icon(Icons.supervised_user_circle),
              onPressed: () {},
            ),
            // ProfileMenu(
            //   text: "Help Center",
            //   icon: const Icon(Icons.supervised_user_circle),
            //   onPressed: () {},
            // ),
            ProfileMenu(
              text: "Log Out",
              icon: const Icon(Icons.supervised_user_circle),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginMekanik()),
                  (Route<dynamic> route) => false,
                );
                // Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
