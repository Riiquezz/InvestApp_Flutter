import 'package:InvestFlutter/pages/mainScreen.dart';
import 'package:InvestFlutter/utils/constants.dart';
import 'package:flutter/material.dart';
import '../utils/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page.dart';
import '../main.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();
  final _cloudStorage = FirebaseFirestore.instance;
  String state, city;
  bool showProgress = false;
  String email, password;

  bool userLogin = false;

  @override
  void initState() {
    getStateAndCityData();
    checkUserStatus();

    super.initState();
  }

  void checkUserStatus() async {
    String userId = await storage.read(key: 'userId');

    if (userId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  void getStateAndCityData() async {
    Location location = Location();
    await location.getCurrentPosition();

    await location.getCurrentPositionDataLatLong(
      location.latitude,
      location.longitude,
    );

    state = location.state;
    city = location.city;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey[900]])),
        child: Center(
          child: ModalProgressHUD(
            inAsyncCall: showProgress,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('lib/assets/logo.png'),
                      width: 300.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value; // get value from TextField
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value; //get value from textField
                      },
                      decoration: InputDecoration(
                        hintText: "Senha",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      elevation: 5,
                      color: SECONDARY_DARK,
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () async {
                            setState(() {
                              showProgress = true;
                            });

                            try {
                              final newUser =
                                  await _auth.signInWithEmailAndPassword(
                                email: email,
                                password: password,
                              );

                              if (newUser != null) {
                                await storage.write(
                                  key: 'userId',
                                  value: newUser.user.uid,
                                );

                                Fluttertoast.showToast(
                                  msg: "Sucesso",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.blueAccent,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );

                                setState(() {
                                  showProgress = false;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainScreen(),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Opa! Tente novamente mais tarde.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.redAccent,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                setState(() {
                                  showProgress = false;
                                });
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "Opa! Tente novamente mais tarde.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.redAccent,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                              setState(() {
                                showProgress = false;
                              });
                            }
                          },
                          child: Text(
                            "Entrar",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      },
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: SECONDARY_DARK),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Ainda não tem cadastro?\n           Cadastre-se!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (email != null) {
                          setState(() {
                            showProgress = true;
                          });

                          await _auth.sendPasswordResetEmail(email: email);

                          setState(() {
                            showProgress = false;
                          });
                        } else {
                          Fluttertoast.showToast(
                            msg: "Opa! Tente novamente mais tarde.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.redAccent,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        }
                      },
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: SECONDARY_DARK),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Esqueci minha senha :(",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
