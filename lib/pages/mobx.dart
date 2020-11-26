import 'package:InvestFlutter/controller/controller.dart';
import 'package:InvestFlutter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../utils/location.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'home_page.dart';
import '../main.dart';

class MobxTest extends StatefulWidget {
  @override
  _MobxTestState createState() => _MobxTestState();
}

class _MobxTestState extends State<MobxTest> {
  final controller = Controller();

  void _incrementCounter() {
    setState(() {
      controller.increment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('MobX'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white, Colors.grey[900]])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Aperte no botão e veja a mágica :O"),
              SizedBox(
                height: 100.0,
              ),
              Text("Você já apertou o botão"),
              SizedBox(
                height: 20.0,
              ),
              Observer(builder: (_) {
                return Text(
                  '${controller.numeroDeClicks}',
                );
              }),
              SizedBox(
                height: 20.0,
              ),
              Text("vezes"),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: SECONDARY_DARK,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
