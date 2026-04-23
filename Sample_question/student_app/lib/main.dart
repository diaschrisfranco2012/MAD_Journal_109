import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'register.dart';

// ==========================================
// 🚀 THE ENGINE: main()
// ==========================================
void main() async {
  // Before Firebase can start, Flutter needs to make sure its internal engine is fully awake.
  WidgetsFlutterBinding.ensureInitialized();
  
  // This connects your app to the Firebase cloud. 
  await Firebase.initializeApp();
  
  // Launches the app basically
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false, // Hides the red debug sticker
      home: RegisterScreen(), // Opens the Registration screen first
    );
  }
}