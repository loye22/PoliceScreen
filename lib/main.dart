import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tsti_signature/screens/create_signature.dart';
import 'package:tsti_signature/screens/homePage.dart';
import 'package:tsti_signature/screens/loginPage.dart';
import 'package:tsti_signature/widgets/sendginForm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var DefaultFirebaseOptions;
  await Firebase.initializeApp();
  // Force landscape orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return homePage();
          } else {
            return loginPage();
          }
        },

      ),
      routes: {
        homePage.routeName: (ctx) => homePage(),
        sendginForm.routeName: (ctx) => sendginForm(rec: [] , tab: 0),
        loginPage.routeName: (ctx) => loginPage(),
      },
    );
  }
}
