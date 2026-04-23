import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'display.dart';

// Part B: Student Registration Form
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Think of this like a tiny storage box for ONLY gender
  // Whenever this value changes, only the UI listening to it will rebuild
  // Using ValueNotifier because StatelessWidget cannot rebuild itself, so this lets only the gender part update without making the whole screen Stateful.
  // If we used StatefulWidget, this would be simpler (just setState), but ValueNotifier is used here so we can keep the widget Stateless and still update only the gender part without rebuilding the whole screen.
  final ValueNotifier<String?> _genderNotifier = ValueNotifier<String?>('Male');

  // This is like a "form controller system" that keeps track of user input
  final _formKey = GlobalKey<FormState>();

  // These controllers help us read what the user types
  final TextEditingController nameController = TextEditingController();
  final TextEditingController rollController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration App"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        // Form groups all input fields so we can validate them together
        child: Form(
          key: _formKey,

          // ListView is used instead of Column so keyboard won’t break layout
          child: ListView(
            children: [
              // ===== NAME FIELD =====
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Student Name"),

                // If empty, show error message
                validator: (val) => val!.isEmpty ? "Enter Name" : null,
              ),

              // ===== ROLL NUMBER FIELD =====
              TextFormField(
                controller: rollController,
                decoration: const InputDecoration(labelText: "Roll No"),
                validator: (val) => val!.isEmpty ? "Enter Roll" : null,
              ),

              // ===== PHONE NUMBER FIELD =====
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                validator: (val) => val!.isEmpty ? "Enter Phone" : null,
              ),

              const SizedBox(height: 20),

              const Text(
                "Select Gender:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              // 🔥 This listens to gender changes and rebuilds ONLY this part
              ValueListenableBuilder(
                valueListenable: _genderNotifier,
                builder: (context, currentGender, child) {
                  return Column(
                    children: [
                      // ===== MALE OPTION =====
                      RadioListTile<String>(
                        title: const Text("Male"),
                        value: "Male",

                        // This decides which radio is selected
                        groupValue: currentGender,

                        // When user taps, update the value in the box
                        onChanged: (val) {
                          _genderNotifier.value = val;
                        },
                      ),

                      // ===== FEMALE OPTION =====
                      RadioListTile<String>(
                        title: const Text("Female"),
                        value: "Female",
                        groupValue: currentGender,
                        onChanged: (val) {
                          _genderNotifier.value = val;
                        },
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              // ===== SUBMIT BUTTON =====
              ElevatedButton(
                child: const Text("Submit"),

                onPressed: () async {
                  // First check if all fields are valid
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Save data into Firestore database (cloud storage)
                      await FirebaseFirestore.instance
                          .collection('students')
                          .add({
                            'name': nameController.text.trim(),
                            'roll': rollController.text.trim(),
                            'phone': phoneController.text.trim(),

                            // Take current gender from our ValueNotifier box
                            'gender': _genderNotifier.value,
                          });

                      // Safety check: make sure screen is still active
                      if (!context.mounted) return;

                      // Show success message at bottom
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Record Saved!")),
                      );

                      // Go to display screen after saving data
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DisplayStudentInfo(),
                        ),
                      );
                    } catch (e) {
                      // If something breaks (like Firebase error), show message
                      if (!context.mounted) return;

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
