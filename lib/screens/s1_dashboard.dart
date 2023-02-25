import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../app_bar/appBar_dashboard.dart';
import '../image_assets.dart';
import '../spite.dart';
import './leader_board.dart';

var fullname = "..";

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _amountTC = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Do you really want to exit app?"),
                actionsAlignment: MainAxisAlignment.spaceBetween,
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: TextButton.icon(
                        onPressed: () => exit(0),
                        icon: Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                        label: Text(
                          "Yes",
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                    child: TextButton.icon(
                        onPressed: () => Navigator.pop(context, false),
                        icon: Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                        label: Text(
                          "No",
                          style: TextStyle(fontFamily: "productSans"),
                        )),
                  )
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: Scaffold(
            appBar: appBarDashboard(context),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                bodyForDashboard(context),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.76, 10, 20, 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LeaderBoard()));
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 16, 0),
                      child: Chip(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        elevation: 1,
                        backgroundColor: Colors.green[100],
                        deleteIcon: Icon(Icons.leaderboard),
                        onDeleted: () {},
                        label: Text(
                          "Leaderboard",
                          style:
                              TextStyle(fontSize: 20, color: Colors.teal[700]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget bodyForDashboard(context) {
    return ListView(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.015,
      ),
      ImageAssets.appIcon(),
      Column(children: [
        Form(
            key: _formKey,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                        padding: const EdgeInsets.only(top: 5, bottom: 20),
                        alignment: Alignment.center,
                        child: Text(
                          "Hi, " + getFullName() + " ✌	",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 30),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(150, 0, 150, 0),
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _amountTC,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Amount to invest',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          prefixIcon: Icon(
                            Icons.currency_rupee_outlined,
                            color: Colors.deepPurple,
                          ),
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter amount';
                          }
                          return null;
                        },
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //////////////////////////////////////
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.play_circle,
                          size: 35,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stack(children: [
                                          GameWidget(game: mySprite(context)),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashboardPage()));
                                                },
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.indigo,
                                                  child: Icon(
                                                    Icons.arrow_back_outlined,
                                                    size: 40,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          )
                                        ])));
                          }
                        },
                        label: const Text(
                          'Play',
                          style: TextStyle(fontSize: 21),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        SizedBox(
          height: 30,
        )
      ]),
    ]);
  }

  String getFullName() {
    FirebaseFirestore.instance
        .collection('db')
        .doc('users_db')
        .collection('user_details')
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .get()
        .then((value) {
      fullname = value['name'];
    });
    return fullname;
  }
}
