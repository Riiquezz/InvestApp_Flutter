import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class PlatformChannel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('Platform Channel'),
      ),
      body: new MyplatformChannel(),
    );
  }
}

class MyplatformChannel extends StatefulWidget {
  MyplatformChannel({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyplatformChannelState createState() => new _MyplatformChannelState();
}

class _MyplatformChannelState extends State<MyplatformChannel> {
  static const platform = const MethodChannel('flutter.native/helper');
  String _responseFromNativeCode = 'Aguardando resposta...';
  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      _responseFromNativeCode = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.grey[300], Colors.grey[900]])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                child: Text('Em que plataforma estou rodando?'),
                onPressed: responseFromNativeCode,
              ),
              Text(_responseFromNativeCode),
            ],
          ),
        ),
      ),
    );
  }
}
