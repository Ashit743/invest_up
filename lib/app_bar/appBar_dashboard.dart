import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invest_up/image_assets.dart';

import '../authentication/signin_page.dart';

PreferredSizeWidget appBarDashboard(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: Icon(Icons.home_filled, color: Colors.blue,),
    title: Text(
      "Welcome to",
      style: TextStyle(letterSpacing: 1, wordSpacing: 5,fontSize: 28, color: Colors.blue),
    ),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 85,
    actions: [
      Container(
        child: TextButton.icon(onPressed: (){
          CoolAlert.show(
              context: context,
              type: CoolAlertType.confirm,
              text: "You are about to logout!",
              onConfirmBtnTap: () {
                _signOut(context);
              });
        } , icon: const Icon(Icons.logout,color: Colors.blue,),
        label: Text("Logout", style: TextStyle(color: Colors.blue, fontSize: 18),),
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.06,
      )
    ],
  );
}

_signOut(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) => SignInPage()));
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Logged out successfully!'),
    ),
  );
}