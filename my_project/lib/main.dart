import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/addmedicine.dart';  // Correct import
import 'package:my_project/firebase_options.dart';
import 'package:my_project/medicine.dart';  // Ensure only this contains MyMedicine

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medicine Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyMedicine(),  // Ensure this comes only from medicine.dart
      debugShowCheckedModeBanner: false,
      routes: {
        '/addmedicine': (context) => const AddMedicine(),  // Ensure AddMedicine is imported properly
      },
    );
  }
}
