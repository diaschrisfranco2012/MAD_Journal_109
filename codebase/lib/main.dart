import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure you have configured Firebase using flutterfire configure
  await Firebase.initializeApp(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore Code Saver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CodeStoragePage(),
    );
  }
}

class CodeStoragePage extends StatefulWidget {
  const CodeStoragePage({super.key});

  @override
  State<CodeStoragePage> createState() => _CodeStoragePageState();
}

class _CodeStoragePageState extends State<CodeStoragePage> {
  // Controller for the Firestore Collection name
  final TextEditingController _collectionController = TextEditingController();
  
  // List to hold the dynamically generated text controllers
  final List<Map<String, TextEditingController>> _codeFields = [];

  // Function to add a new pair of TextFields
  void _addCodeField() {
    setState(() {
      _codeFields.add({
        'codeName': TextEditingController(),
        'codeValue': TextEditingController(),
      });
    });
  }

  // Function to remove a specific pair of TextFields
  void _removeCodeField(int index) {
    setState(() {
      _codeFields[index]['codeName']?.dispose();
      _codeFields[index]['codeValue']?.dispose();
      _codeFields.removeAt(index);
    });
  }

  // Function to save the data to Firestore
  Future<void> _saveToFirestore() async {
    final collectionName = _collectionController.text.trim();

    if (collectionName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a collection name!')),
      );
      return;
    }

    if (_codeFields.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one code entry!')),
      );
      return;
    }

    // Prepare the data to be saved as a map
    Map<String, String> dataToSave = {};
    for (var field in _codeFields) {
      String name = field['codeName']!.text.trim();
      String value = field['codeValue']!.text.trim();
      
      if (name.isNotEmpty && value.isNotEmpty) {
        dataToSave[name] = value;
      }
    }

    if (dataToSave.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in the code fields!')),
      );
      return;
    }

    try {
      // Save data as a new document in the specified collection
      await FirebaseFirestore.instance
          .collection(collectionName)
          .add(dataToSave);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Codes saved successfully!')),
      );

      // Optional: Clear fields after saving
      _collectionController.clear();
      for (var field in _codeFields) {
        field['codeName']?.dispose();
        field['codeValue']?.dispose();
      }
      setState(() {
        _codeFields.clear();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  void dispose() {
    _collectionController.dispose();
    for (var field in _codeFields) {
      field['codeName']?.dispose();
      field['codeValue']?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save Codes to Firestore'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input for Collection Name
            TextField(
              controller: _collectionController,
              decoration: const InputDecoration(
                labelText: 'Firestore Collection Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.folder),
              ),
            ),
            const SizedBox(height: 16),
            
            // Dynamic List of Code Fields
            Expanded(
              child: ListView.builder(
                itemCount: _codeFields.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  controller: _codeFields[index]['codeName'],
                                  decoration: const InputDecoration(
                                    labelText: 'Code Name (e.g. API_KEY)',
                                  ),
                                ),
                                TextField(
                                  controller: _codeFields[index]['codeValue'],
                                  decoration: const InputDecoration(
                                    labelText: 'Code Value',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeCodeField(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveToFirestore,
                child: const Text('Save to Firestore', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button to add new fields
      floatingActionButton: FloatingActionButton(
        onPressed: _addCodeField,
        tooltip: 'Add Code Field',
        child: const Icon(Icons.add),
      ),
    );
  }
}