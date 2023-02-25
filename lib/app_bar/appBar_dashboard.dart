import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/signin_page.dart';

PreferredSizeWidget appBarDashboard(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.area_chart_rounded,
        size: 30,
      ),
      onPressed: () {

      },
    ),
    title: Text(
      "Welcome to Fun'D",
      style: TextStyle(letterSpacing: 1, wordSpacing: 5),
    ),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 75,
    actions: [
      Container(
        child: TextButton.icon(onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SignInPage()));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logged out successfully!'),
            ),
          );
        }, icon: Icon(Icons.logout,color: Colors.white,),
        label: Text("Logout", style: TextStyle(color: Colors.white),),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.06,
      )
    ],
  );
}