import 'package:flutter/material.dart';

Widget homeAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: MediaQuery.of(context).size.height * 0.07,
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white,
    leading: Container(),
    title: Text(
      'Home',
      style: TextStyle(color: Colors.black),
    ),
  );
}
