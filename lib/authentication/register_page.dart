import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:invest_up/authentication/signin_page.dart';
import 'package:invest_up/screens/s1_dashboard.dart';

import '../app_bar/appBar_signup.dart';
import '../spite.dart';

//Create a CollectionReference that references the firestore collection
CollectionReference db = FirebaseFirestore.instance.collection('db');

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameTC = TextEditingController();
  final TextEditingController _phoneTC = TextEditingController();
  final TextEditingController _panNumberTC = TextEditingController();

  //registration details
  late String name,
      phone,
      pan_number;

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
            appBar: appBarSignUp(context),
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                bodyForSignUp(context),
              ],
            )),
      ),
    );
  }

  Widget bodyForSignUp(context) {
    return ListView(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      Column(children: [
        Form(
            key: _formKey,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        prefixIcon: Icon(
                          Icons.email_rounded,
                          color: Colors.deepPurple,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty || (!value.contains("@"))) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password (min. 6 characters)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.deepPurple,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 6)
                          return "Minimum 6 characters required";
                        return null;
                      },
                      obscureText: true,
                    ),

                    SizedBox(
                      height: 15,
                    ),
                    ///////////////////////////////////////--------->>> registration details
                    TextFormField(
                      controller: _nameTC,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          color: Colors.deepPurple,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15,
                    ),

                    TextFormField(
                      controller: _phoneTC,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50)),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.deepPurple,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (value.length < 10 || value.length > 10)
                          return "Invalid phone! Must contain 10 digits only.";
                        return null;
                      },
                    ),

                    SizedBox(
                      height: 15,
                    ),

                      Column(
                        children: [
                          TextFormField(
                            controller: _panNumberTC,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              labelText: 'PAN',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              prefixIcon: Icon(
                                Icons.numbers,
                                color: Colors.deepPurple,
                              ),
                            ),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Please enter your PAN number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),

                    //////////////////////////////////////
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.person_add),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _register();
                          }
                        },
                        label: Text('Sign Up'),
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(fontSize: 15, color: Colors.blueGrey[600]),
            ),
            GestureDetector(
              onTap: () {
                if (FirebaseAuth.instance.currentUser == null)
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                else {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => GameWidget(game: mySprite())));
                }
              },
              child: Text(
                ' Sign In ',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ]),
    ]);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return db
        .doc("users_db")
        .collection("user_details")
        .doc(FirebaseAuth.instance.currentUser!.email.toString())
        .set({
          'email': _emailController.text,
          'name': _nameTC.text,
          'phone': _phoneTC.text,
          'pan_number': _panNumberTC.text,
          'last_modified_on': DateTime.now()
        })
        .then((value) => print("User Added"))
        .catchError((error) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: "Sign Up failed!",
          );
          print(error);
        });
  }

  // Code for registration.
  Future<void> _register() async {
    final User? user =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
            .user;
    if (user != null) {
      //add user data in db
      addUser();
      setState(() {
        // toastAlert("Successfully Registered !", context);
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Successfully registered!",
            onConfirmBtnTap: () {
              if (FirebaseAuth.instance.currentUser != null)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
              else
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
            });
        resetRegistrationFields();
      });
    } else {}
  }

  //Reset All Fields
  void resetRegistrationFields() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _nameTC.clear();
      _phoneTC.clear();
      _panNumberTC.clear();
    });
  }
}
