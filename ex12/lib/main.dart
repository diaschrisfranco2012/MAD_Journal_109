import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const StudentApp());
}

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Registration',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}


class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

// 1) AUTHENTICATION SCREENS

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: Colors.black)),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 50),
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(onTap: signUserIn, text: "Sign In"),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: Colors.black)),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registration Successful"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person_add, size: 100),
                const SizedBox(height: 50),
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(onTap: signUserUp, text: "Register"),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// 2) HOME SCREEN (StatelessWidget)

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void logUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Registration App"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => logUserOut(context),
          ),
        ],
      ),
      body: const StudentRegistrationForm(),
    );
  }
}

class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});

  @override
  State<StudentRegistrationForm> createState() =>
      _StudentRegistrationFormState();
}

class _StudentRegistrationFormState extends State<StudentRegistrationForm> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  String selectedCourse = 'BCA';
  final List<String> courses = ['BCA', 'BBA', 'BSc', 'BA', 'BCom'];

  String selectedGender = 'Male';

  void submitData() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) return;

    await FirebaseFirestore.instance.collection('students').add({
      'name': nameController.text.trim(),
      'course': selectedCourse,
      'phone': phoneController.text.trim(),
      'gender': selectedGender,
      'timestamp': FieldValue.serverTimestamp(),
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Record Saved Successfully"),
          backgroundColor: Colors.green,
        ),
      );
      // Navigate to DisplayScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DisplayStudentInfo()),
      );
      // Clear form
      nameController.clear();
      phoneController.clear();
      setState(() {
        selectedCourse = 'BCA';
        selectedGender = 'Male';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          MyTextField(
            controller: nameController,
            hintText: 'Student Name',
            obscureText: false,
          ),
          const SizedBox(height: 15),
          MyTextField(
            controller: phoneController,
            hintText: 'Phone Number',
            obscureText: false,
          ),
          const SizedBox(height: 15),

          // Dropdown for Course
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.white),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCourse,
                  isExpanded: true,
                  items: courses.map((String course) {
                    return DropdownMenuItem<String>(
                      value: course,
                      child: Text(course),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() => selectedCourse = newValue!);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Radio Buttons for Gender
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: [
                const Text(
                  "Gender:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Radio<String>(
                  value: 'Male',
                  groupValue: selectedGender,
                  activeColor: Colors.black,
                  onChanged: (value) => setState(() => selectedGender = value!),
                ),
                const Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: selectedGender,
                  activeColor: Colors.black,
                  onChanged: (value) => setState(() => selectedGender = value!),
                ),
                const Text('Female'),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Primary Submit Button
          MyButton(onTap: submitData, text: "Submit"),
          const SizedBox(height: 25),

          // --- Secondary Button to view records without submitting ---
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DisplayStudentInfo(),
                ),
              );
            },
            child: const Text(
              "View Registered Students ➔",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}


// 3) DISPLAY SCREEN (CRUD: Read, Update, Delete)

class DisplayStudentInfo extends StatefulWidget {
  const DisplayStudentInfo({super.key});

  @override
  State<DisplayStudentInfo> createState() => _DisplayStudentInfoState();
}

class _DisplayStudentInfoState extends State<DisplayStudentInfo> {
  bool _isDisplaying = false;

  void updateStudent(
    String docId,
    String currentName,
    String currentPhone,
    String currentCourse,
    String currentGender,
  ) {
    TextEditingController editNameController = TextEditingController(
      text: currentName,
    );
    TextEditingController editPhoneController = TextEditingController(
      text: currentPhone,
    );

    String editCourse = currentCourse;
    String editGender = currentGender;
    final List<String> courses = ['BCA', 'BBA', 'BSc', 'BA', 'BCom'];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            backgroundColor: Colors.grey[300],
            title: const Text("Edit Student Details"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: editNameController,
                    decoration: const InputDecoration(labelText: "Full Name"),
                  ),
                  TextField(
                    controller: editPhoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Course Edit Dropdown
                  const Text(
                    "Course:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: editCourse,
                    isExpanded: true,
                    items: courses.map((String course) {
                      return DropdownMenuItem<String>(
                        value: course,
                        child: Text(course),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setStateDialog(() => editCourse = newValue!);
                    },
                  ),
                  const SizedBox(height: 15),

                  // Gender Edit Radio Buttons
                  const Text(
                    "Gender:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Male',
                        groupValue: editGender,
                        activeColor: Colors.black,
                        onChanged: (value) =>
                            setStateDialog(() => editGender = value!),
                      ),
                      const Text('Male'),
                      Radio<String>(
                        value: 'Female',
                        groupValue: editGender,
                        activeColor: Colors.black,
                        onChanged: (value) =>
                            setStateDialog(() => editGender = value!),
                      ),
                      const Text('Female'),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: () async {
                  // Updating all 4 fields in Firestore
                  await FirebaseFirestore.instance
                      .collection('students')
                      .doc(docId)
                      .update({
                        'name': editNameController.text.trim(),
                        'phone': editPhoneController.text.trim(),
                        'course': editCourse,
                        'gender': editGender,
                      });
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Record Updated Successfully"),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }
                },
                child: const Text(
                  "Update",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void deleteStudent(String docId) async {
    await FirebaseFirestore.instance.collection('students').doc(docId).delete();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Record Deleted"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registered Students")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          MyButton(
            onTap: () {
              setState(() {
                _isDisplaying = true;
              });
            },
            text: "Display Database",
          ),
          const SizedBox(height: 20),

          if (_isDisplaying)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('students')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No students registered yet."),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var student = snapshot.data!.docs[index];
                      var docId = student.id;

                      String name = student['name'] ?? '';
                      String phone = student['phone'] ?? '';
                      String course =
                          (student.data() as Map<String, dynamic>).containsKey(
                            'course',
                          )
                          ? student['course']
                          : 'BCA';
                      String gender =
                          (student.data() as Map<String, dynamic>).containsKey(
                            'gender',
                          )
                          ? student['gender']
                          : 'Male';

                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Course: $course  •  Gender: $gender \nPhone: $phone",
                              style: TextStyle(
                                color: Colors.grey[800],
                                height: 1.4,
                              ),
                            ),
                          ),
                          isThreeLine: true,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                onPressed: () => updateStudent(
                                  docId,
                                  name,
                                  phone,
                                  course,
                                  gender,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => deleteStudent(docId),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
