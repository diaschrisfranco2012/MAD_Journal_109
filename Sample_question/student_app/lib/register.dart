import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  // CONTROLLERS: Think of these like little buckets.
  // When the user types their email, it drops into the 'email' bucket so we can use it later.
  final email = TextEditingController();
  final pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Student Registration")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // The Email text box connects to the 'email' bucket
            TextFormField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            // The Password box connects to the 'pass' bucket
            TextFormField(
              controller: pass,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText:
                  true, // This turns the password into hidden dots! *** for some privacy so u can impress the examiner for giving extra marks. Nah just Kidding!!!
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              child: const Text("Register"),
              onPressed: () async {
                // 1️.VALIDATION: Check if the buckets are empty
                if (email.text.isEmpty || pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Fields cannot be empty")),
                  );
                  return; // 'return' acts like a stop sign. It stops the code from running any further.
                }

                // 2️.FIREBASE work: Try to create the account
                // 'try' means "attempt to do this, but if it crashes, catch the error instead of breaking the app"
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );

                  // 3️.CONTEXT SAFETY: Checks if the widget is still on screen before using context, to avoid errors after async operations.
                  if (!context.mounted) return;

                  // 4️.SUCCESS MESSAGE
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Registration Successful")),
                  );

                  // 5️.NAVIGATION: Send them to the Login screen

                  // Navigator.push → Moves to a new screen (adds LoginScreen on top of current screen)
                  // context → Gives current screen information so Flutter knows where to navigate from
                  // MaterialPageRoute → Defines the transition animation and route to the new screen
                  // builder: (_) => LoginScreen() → Creates and returns the LoginScreen widget to display
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                } catch (e) {
                  // If Firebase complains (like "password too weak"), it shows the error here.
                  // Runs when an error happens (e.g., Firebase signup/login fails)
                  if (!context.mounted) return;

                  // Shows a small popup message at the bottom of the screen with the error details
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
