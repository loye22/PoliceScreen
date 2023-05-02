import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Button.dart';
import '../models/MyDialog.dart';


class loginPage extends StatefulWidget {
  static const routeName = '/loginPage';

  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _key = GlobalKey<FormState>();
  String _eamil = '';
  String _passwd = '';
  bool _isLoading = false;

  void _submit() {
    final v = _key.currentState?.validate();

    if (v != null) {
      _key.currentState?.save();
      FocusScope.of(context).unfocus();
      //log in logic ...
      // print(_passwd + " " + _eamil);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.red,
                gradient: LinearGradient(colors: [
                  Color.fromRGBO(56, 142, 60, 1),
                  Color.fromRGBO(76, 175, 80, 1),
                  Color.fromRGBO(139, 195, 74, 1),
                ])),
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.13)),
                color: Colors.grey.shade200.withOpacity(0.25),
              ),
            ),
          ),
          Center(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      //        height: 150,
                    ),
                    CircleAvatar(
                      radius: 80,

                      backgroundImage: AssetImage("assests/tsti.png"  ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 300,
                      child: TextFormField(
                          key: ValueKey('username'),
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            labelText: 'email',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200.withOpacity(0.45),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                          ),
                          onSaved: (val) {
                            if (val != null) {
                              val = val?.replaceAll(" ", "").toString();
                              _eamil = val!;
                            }
                          },
                          validator: (val) {
                            if (val == null) {
                              return;
                            }
                            //   val = val?.replaceAll(" ", "").toString();
                          }),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 40,
                      width: 300,
                      child: TextFormField(
                        key: ValueKey('password'),
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password, color: Colors.white),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade200.withOpacity(0.45),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16.0),
                        ),
                        onSaved: (val) {
                          if (val != null) {
                            //val = val?.replaceAll(" ", "").toString();
                            _passwd = val;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Button(
                          txt: "Log in ",
                          icon: Icons.login,
                          isSelected: true,
                          onPress: () async {
                            try {
                              _submit();
                              setState(() {this._isLoading = true;});

                              dynamic res = await signInWithEmailAndPassword(
                                  _eamil, _passwd, context)
                                  .then((value) => null);

                            } catch (e) {
                              String displayMessage = e
                                  .toString()
                                  .substring(e.toString().indexOf("]") + 2);
                              print("error  $e");
                              if (mounted) {
                                MyDialog.showAlert(
                                    context, '$displayMessage');
                                setState(() {
                                  this._isLoading = false;
                                });
                              }
                            } finally {}
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

/*
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print(result);


    return result;
  }

  */

  Future<UserCredential> signInWithEmailAndPassword(
      String emaile, String password, BuildContext ctx) async {
/*
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: 'louie@l.com', password: 'louie@l.com');

    await FirebaseFirestore.instance
        .collection('Adminusers')
        .doc(userCredential.user!.uid)
        .set({'userName': 'louie@l.com', 'email': 'louie@l.com'});
    return userCredential;*/



    final FirebaseAuth _auth = FirebaseAuth.instance;
    // Sign in with email and password
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: emaile,
      password: password,
    );
    // Retrieve the user's document from Firestore
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Adminusers')
        .doc(result.user!.uid)
        .get();
    // Set the user's name and email from the document
    String name = await userDoc.get('userName');
    String email = await userDoc.get('email');
    // Generate a token and store it in the provider
    String token = await result.user!.getIdToken();
    return result;

  }

}
