import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("HOME SCREEN",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),),);
  }
}