import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayStudentInfo extends StatelessWidget {
  const DisplayStudentInfo({super.key});

  // This is just a shortcut so we don't have to type the whole
  // FirebaseFirestore.instance... line every single time.
  CollectionReference get students =>
      FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Students"),
        centerTitle: true,
      ),

      // THE LIVE FEED (StreamBuilder)
      // Think of this like a WhatsApp chat. As soon as a message (or student)
      // is added to the database, this widget "hears" it and refreshes the screen automatically.
      body: StreamBuilder<QuerySnapshot>(
        stream: students
            .snapshots(), // This is the "Ear" listening to Firestore
        builder: (context, snapshot) {
          // 1. While the app is still "calling" the database, show a loading spinner
          // snapshot = a real-time container that holds Firestore data, loading state, and errors while fetching or listening to database changes
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. If the database comes back empty, tell the user
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No records found"));
          }

          // 3. THE LIST (ListView)
          // This builds a scrollable list of all the students found in the cloud.
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              // 'doc' is the specific folder for one student
              var doc = snapshot.data!.docs[index];
              // 'data' is the actual paper inside that folder with the name/roll/phone
              var data = doc.data() as Map<String, dynamic>;

              // We use ?? '' to make sure that if a field is missing, the app doesn't crash
              String name = data['name'] ?? '';
              String roll = data['roll'] ?? 'N/A';
              String phone = data['phone'] ?? '';
              String gender = data['gender'] ?? 'N/A';

              return ListTile(
                title: Text(name),
                subtitle: Text("Roll: $roll | Phone: $phone | Gender: $gender"),
                trailing: Row(
                  mainAxisSize:
                      MainAxisSize.min, // Keeps the buttons tight to the right
                  children: [
                    // THE EDIT BUTTON
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _editDialog(context, doc.id, data),
                    ),

                    // 🗑 THE DELETE BUTTON (The "D" in CRUD)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // This tells Firebase: "Find the document with this ID and delete it."
                        await students.doc(doc.id).delete();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ==========================================
  //  THE EDIT POPUP BOX (The "U" in CRUD)
  // ==========================================
  void _editDialog(BuildContext context, String id, Map<String, dynamic> data) {
    // We fill the text boxes with the current info so the user knows what they are editing
    TextEditingController name = TextEditingController(
      text: data['name'] ?? '',
    );
    TextEditingController roll = TextEditingController(
      text: data['roll'] ?? '',
    );
    TextEditingController phone = TextEditingController(
      text: data['phone'] ?? '',
    );

    // Just like the Home Screen, we use a ValueNotifier bucket for the gender
    // so we can change the radio buttons inside this popup!
    ValueNotifier<String?> editGenderNotifier = ValueNotifier<String?>(
      data['gender'] ?? 'Male',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Student"),
          // SingleChildScrollView prevents "Yellow Tape" errors when the keyboard pops up
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: name,
                  decoration: const InputDecoration(labelText: "Name"),
                ),
                TextField(
                  controller: roll,
                  decoration: const InputDecoration(labelText: "Roll No"),
                ),
                TextField(
                  controller: phone,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),

                const SizedBox(height: 15),
                const Text(
                  "Update Gender:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                // This "Listens" to our gender bucket and redraws the radio buttons when clicked
                ValueListenableBuilder(
                  valueListenable: editGenderNotifier,
                  builder: (context, currentGender, child) {
                    return Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text("Male"),
                          value: "Male",
                          groupValue: currentGender,
                          onChanged: (val) => editGenderNotifier.value = val,
                        ),
                        RadioListTile<String>(
                          title: const Text("Female"),
                          value: "Female",
                          groupValue: currentGender,
                          onChanged: (val) => editGenderNotifier.value = val,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            // Cancel button just closes the box
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),

            // Update button sends the new info to the Cloud
            ElevatedButton(
              onPressed: () async {
                // UPDATE FIRESTORE: This finds the document by ID and replaces the values
                await FirebaseFirestore.instance
                    .collection('students')
                    .doc(id)
                    .update({
                      'name': name.text.trim(),
                      'roll': roll.text.trim(),
                      'phone': phone.text.trim(),
                      'gender': editGenderNotifier
                          .value, // Saves the new selected gender!
                    });

                if (!context.mounted) return;
                Navigator.pop(context); // Close the popup

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Record Updated")));
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}
