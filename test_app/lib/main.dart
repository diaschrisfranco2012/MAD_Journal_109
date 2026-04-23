import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.deepPurple[200],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[400],
          title: Text(
            "My App Bar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          leading:Icon(Icons.menu),
          actions: [
            IconButton(
              onPressed: () {
                print("Logout clicked");
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(50),
            // child: Text("Chris dias",
            // style: TextStyle(
            //   color:Colors.white,
            //   fontSize: 28,
            //   fontWeight: FontWeight.bold
            // ),),
            child: Icon(Icons.favorite, color: Colors.pink[200], size: 64),
          ),
        ),
      ),
    );
  }
}
