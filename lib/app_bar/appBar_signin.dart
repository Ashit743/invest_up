import 'package:flutter/material.dart';

PreferredSizeWidget appBarSignIn(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 30,
      ),
      onPressed: () {

      },
    ),
    title: Text(
      "Sign In",
      style: TextStyle(letterSpacing: 1, wordSpacing: 5),
    ),
    elevation: 5,
    centerTitle: true,
    toolbarHeight: 75,
    actions: [
      Icon(Icons.login),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.07,
      )
    ],
  );
}