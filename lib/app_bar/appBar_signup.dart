import 'package:flutter/material.dart';

import '../authentication/signin_page.dart';

PreferredSizeWidget appBarSignUp(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignInPage()));
      },
    ),
    title: Text(
      "Sign Up",
      style: TextStyle(letterSpacing: 1, wordSpacing: 5, color: Colors.blue, fontSize: 27),
    ),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 70,
    actions: [
      Icon(Icons.person_add, color: Colors.blue,),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.05,
      ),

    ],
  );
}