import 'package:chat_app_live_stream/helper/constance.dart';
import 'package:chat_app_live_stream/ui/widgets/custom_button.dart';
import 'package:chat_app_live_stream/ui/widgets/custom_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'chat_screen.dart';

class Registration extends StatefulWidget {
  static const String id = "REGISTRATION";

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  Future<void> registerUser() async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(
          user: user.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text("Register"),
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
              icon: Icons.email,
              isEmail: true,
              onClickSave: (value) => email = value,
              hintText: 'Email',
            ),
            SizedBox(
              height: 10.0,
            ),
            CustomInputField(
              isPassword: true,
              icon: Icons.lock,
              onClickSave: (value) => password = value,
              hintText: 'Password',
            ),
            CustomButton(
              text: "Register",
              press: () async {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) await registerUser();
              },
            )
          ],
        ),
      ),
    );
  }
}
