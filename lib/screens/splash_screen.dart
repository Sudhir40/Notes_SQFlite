import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'notes_Dashboard.dart';

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return splash_screen();
  }
}
class splash_screen extends State<Splash>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>note_dashboard()));
    });
  }
@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: SizedBox( child: Center(child: SizedBox( height: 200,
            width: 200,child: Image.asset('Assets/images/post-it.png')),)),
      ),
    );
  }
}