import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key}); 

  // Our buckets for the login screen
  // Controllers to capture user input from text fields
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar with title
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        // Column to arrange fields vertically
        child: Column(
          children: [
            // Email input field
            TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            // Password input field 
            TextFormField(
              controller: pass,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true, // Hides password
            ),

            const SizedBox(height: 20),

            TextButton(
              child: const Text("Login"),
              onPressed: () async {
                // 1. BASIC VALIDATION: Check if fields are empty
                if (email.text.isEmpty || pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fields cannot be empty")),
                  );
                  return; // Stop right here
                }

                // 2. FIREBASE LOGIN: Try signing in user with email & password
                // Notice we use 'signInWith...' here instead of 'createUserWith...'
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email.text,
                  password: pass.text,
                );
                // 3. CONTEXT SAFETY: Ensure widget is still active after async call
                if (!context.mounted) return; 

                 // 4. SUCCESS MESSAGE: Show login success popup 
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login Successful")),
                );

                // 5. NAVIGATION: Move user to Home screen after login
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}