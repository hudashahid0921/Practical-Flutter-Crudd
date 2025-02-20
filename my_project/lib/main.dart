import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/addmedicine.dart';
import 'package:my_project/auth.dart';
import 'package:my_project/firebase_options.dart'; 
import 'package:my_project/medicine.dart'; 
import 'package:firebase_auth/firebase_auth.dart';

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
      title: 'Medicine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      // Home screen (initial screen when app starts)
      home: FirebaseAuth.instance.currentUser == null ? const Signup() : const MyMedicine(),

      // Routes setup
      routes: {
        '/addmedicine': (context) => const AddMedicine(),
        '/login': (context) => const Login(),
        '/home': (context) => const MyMedicine(), // Home screen after login
      },
    );
  }
}
