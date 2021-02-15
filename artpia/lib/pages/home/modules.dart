import 'package:flutter/material.dart';

import 'package:artpia/assets/modules.dart';
import 'package:artpia/pages/profile/profile.dart';

Widget homeAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 40,
    elevation: 0.5,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Container(
      width: MediaQuery.of(context).size.width * 2 / 5,
      child: Image.asset('logo-image-path'),
    ),
  );
}