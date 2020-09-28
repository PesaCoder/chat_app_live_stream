import 'package:chat_app_live_stream/helper/constance.dart';
import 'package:chat_app_live_stream/ui/widgets/custom_button.dart';
import 'package:chat_app_live_stream/ui/widgets/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat_screen.dart';

class Login extends StatefulWidget {
  static const String id = "LOGIN";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Login"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                width: 100,
                child: SvgPicture.asset(
                  "assets/chat.svg",
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            CustomInputField(
              isEmail: true,
              onClickSave: (value) => email = value,
              hintText: 'Email',
              icon: Icons.email,
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomInputField(
              isPassword: true,
              onClickSave: (value) => password = value,
              hintText: 'Password',
              icon: Icons.lock,
            ),
            CustomButton(
                text: "Log In",
                press: () {
                  _saveForm();
                }),
          ],
        ),
      ),
    );
  }

  _saveForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await loginUser();
    }
  }

  Future<void> loginUser() async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
          user: user.user,
        ),
      ),
    );
  }
}
