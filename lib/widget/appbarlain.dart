import 'package:bengkel_mekanik/constant/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final icon = CupertinoIcons.moon_stars;

  return AppBar(
    leading: const BackButton(
      color: primaryColor,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.message,
            color: primaryColor,
          ))
    ],
  );
}

// AppBar(
//         title: Text("Mekanik"),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.message))
//         ],
//       )