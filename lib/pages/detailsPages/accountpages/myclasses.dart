import 'package:flutter/material.dart';

class Classes extends StatefulWidget {
  const Classes({super.key});

  @override
  State<Classes> createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("My Classes"),),
      body: Center(
        child: Text("My Classes Page"),
      ),
    );
  }
}