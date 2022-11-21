import 'package:bengkel_mekanik/constant/user.dart';
import 'package:bengkel_mekanik/widget/appbarlain.dart';
import 'package:bengkel_mekanik/widget/button_widget.dart';
import 'package:bengkel_mekanik/widget/number_widget.dart';
import 'package:bengkel_mekanik/widget/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const myUser = User(
    imagePath:
        'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Sarah Abs',
    email: 'sarah.abs@gmail.com',
    about:
        'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}

class AkunSaya extends StatefulWidget {
  const AkunSaya({super.key});

  @override
  State<AkunSaya> createState() => _AkunSayaState();
}

class _AkunSayaState extends State<AkunSaya> {
  // final user = "testesji";
  final user = UserPreferences.myUser;
  String id = '';

  _ambil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('mekanik_login')!;
    });
  }

  Future getBawangs(String id) async {
    try {
      http.Response hasil = await http.get(
          Uri.parse("http://disnakerhaltim.amm-mks.co.id/api/daftarada/$id"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
        print("data kategori sukses");
        print(hasil.body);
        final data = daftaradaFromJson(hasil.body);
        return data;
      } else {
        print("Status Error : " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
      print("errornya : $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(builder: (context) => EditProfilePage()),
              // );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'hehehe',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}

// }