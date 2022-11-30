import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override 
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Portal"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Container(
            width: 300,
            height: 300,
            color: Colors.lightBlue,
            
          )
        ],
      ),
    );
  }
}