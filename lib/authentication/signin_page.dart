import 'package:flame/game.dart';
import 'package:invest_up/app_bar/appBar_signin.dart';
import 'package:invest_up/authentication/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:invest_up/screens/s1_dashboard.dart';
import 'package:path_provider/path_provider.dart';
import '../spite.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarSignIn(context),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _EmailPasswordForm(),
          ],
        ));
  }

  // Code for sign out.
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

/// this will delete cache
Future<void> _deleteCacheDir() async {
  final cacheDir = await getTemporaryDirectory();

  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

/// this will delete app's storage
Future<void> _deleteAppDir() async {
  final appDir = await getApplicationSupportDirectory();

  if (appDir.existsSync()) {
    appDir.deleteSync(recursive: true);
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.01,
      ),
      Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Sign in to continue',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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
                            if (value!.isEmpty)
                              return 'Please enter registered email';
                            else if (!value.contains("@"))
                              return "Please enter a valid email";
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50)),
                            prefixIcon: Icon(
                              Icons.password,
                              color: Colors.deepPurple,
                            ),
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty)
                              return 'Please enter your password';
                            else if (value.length < 6)
                              return "Minimum 6 characters required";
                            return null;
                          },
                          obscureText: true,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.login),
                            label: Text(
                              'Sign In',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await _signInWithEmailAndPassword();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New User? ',
                style: TextStyle(fontSize: 15, color: Colors.blueGrey[600]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => RegisterPage()));
                },
                child: Text(
                  ' Sign Up ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    ]);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  Future<void> _signInWithEmailAndPassword() async {
    try {
      final User? user =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
              .user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed in as ${user!.email}'),
        ),
      );

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DashboardPage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with Email & Password'),
        ),
      );
    }
  }
}
