
import 'package:chatapp/helper/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import 'package:chatapp/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'dart:async';

import 'chatrooms.dart';
import 'signin.dart';
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
Future resetPass(String email) async {
  try {
    return await _auth.sendPasswordResetEmail(email: email);
  } catch (e) {
    print(e.toString());
    return null;
  }
}
TextEditingController emailEditingController = new TextEditingController();


AuthService authService = new AuthService();
class _ForgotPasswordState extends State<ForgotPassword> {

  @override
  Widget build(BuildContext context) {

    return

      Scaffold(
        body:
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
      child: Column(

        children: [
          Container(

            child: Image.asset('assets/images/reset.png'),
            margin: const EdgeInsets.only(top: 100 ,bottom: 50,) ,


          ),

          TextFormField(

            validator: (val) {
              return RegExp(

                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val)
                  ? null
                  : "Please Enter Correct Email";
            },
            controller: emailEditingController,
            style: simpleTextStyle(),
            decoration: textFieldInputDecoration("email"),

          ),


          SizedBox(
            height: 16,
          ),

          GestureDetector(
            onTap: () {

              resetPass(emailEditingController.text);

              Alert(
                  context: context,
                  title: "reset password",
                  desc: "A request has been send to your email to change your password",
                buttons: [
                  DialogButton(
                    child: Text(
                      "COOL",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),

                  )
                ],
                  )

                  .show();
              Future.delayed(const Duration(milliseconds: 3000), () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Authenticate()),
                  );
                });
              });

            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC)
                    ],
                  )),
              margin: const EdgeInsets.only(top: 20 ,right: 50,left: 50) ,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Send Reset Code",
                style: biggerTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],

      ),


    ),

      );
  }
}
