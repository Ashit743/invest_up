import 'package:flutter/material.dart';

import '../authentication/signin_page.dart';

PreferredSizeWidget appBarSignUp(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 30,
      ),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignInPage()));
      },
    ),
    title: Text(
      "Sign Up",
      style: TextStyle(letterSpacing: 1, wordSpacing: 5),
    ),
    elevation: 5,
    centerTitle: true,
    toolbarHeight: 75,
    actions: [
      Icon(Icons.person_add),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.07,
      ),

    ],
  );
}