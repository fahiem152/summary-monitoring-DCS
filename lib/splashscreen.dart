import 'dart:async';
import 'package:flutter/material.dart';
import 'package:monitoring_mobile/home.dart';

class SplashScreen extends StatefulWidget{

  _SplashScreen createState() => _SplashScreen();
}
  class _SplashScreen extends State<SplashScreen>{

  void initState(){
    super.initState();
    splashscreenStart();
  }
  
  splashscreenStart() async{
    var duration = const Duration(seconds: 3);
    return Timer(duration,(){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),

      );
    });
  }
  
  @override 
  Widget build(BuildContext context){
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
            // SizedBox(height: 50,),
          
            children: [
              SizedBox(height: 50,),
              Align(
                alignment: Alignment.topRight,
                child: Image.asset('assets/images/frametop.png'),
              //   child: Column(
              //     children: [
              //       SizedBox(height: 25,),
              //       Container(
              //         width:20,
              //         height: 20,
              //         child: CircleAvatar(backgroundColor: Colors.blue),
              //       ),
              //       SizedBox(width: 90, height: 5,),
              //       Container(
              //         width:30,
              //         height: 30,
              //         child: CircleAvatar(backgroundColor: Colors.blue),
              //       ), 
              //       SizedBox(height: 5,),
              //       Container(
              //         width:40,
              //         height: 40,
              //         child: CircleAvatar(backgroundColor: Colors.blue),
              //       ),
              //     ],
              // )
            ),
            SizedBox(height: 220,),
            Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/group.png'),
            ),
            SizedBox(height: 220,),
             Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset('assets/images/framebottom.png'),
              //   child: Column(
              //     children: [
              //       SizedBox(height: 25,),
              //       Container(
              //         width:20,
              //         height: 20,
              //         child: CircleAvatar(backgroundColor: Colors.blue),
              //       ),
              //       SizedBox(width: 90, height: 5,),
              //       Container(
              //         width:30,
              //         height: 30,
              //         child: CircleAvatar(backgroundColor: Colors.blue),
              //       ), 
              //       SizedBox(height: 5,),
              //       Container(
              //         width:40,
              //         height: 40,
              //         child: CircleAvatar(backgroundColor: Colors.blue),
              //       ),
              //     ],
              // )
            ),
            ]

        ),
      );
 
   }
  }