import 'package:flutter/material.dart';

PreferredSizeWidget appBarSignIn(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.savings_outlined,
        size: 30,
      ),
      onPressed: () {

      },
    ),
    title: Text(
      "Fun'D",
      style: TextStyle(letterSpacing: 1, wordSpacing: 5),
    ),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 75,
    actions: [
      Icon(Icons.area_chart_rounded),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.07,
      )
    ],
  );
}