import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future<void> signUpUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String phone = phoneController.text.trim();

    print("🚀 Sign Up Button Pressed");

    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      print("❌ Error: All fields are required.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }
    if (!email.contains("@") || !email.contains(".")) {
      print("❌ Error: Invalid Email Format");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter a valid email!")),
      );
      return;
    }
    if (password.length < 6) {
      print("❌ Error: Password too short");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters long!")),
      );
      return;
    }

    try {
      print("🔥 Creating User in Firebase Authentication...");

      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("✅ Firebase Authentication Success! User ID: ${userCredential.user!.uid}");

      print("📂 Saving User Data to Firestore...");

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'uid': userCredential.user!.uid,
      });

      print("✅ User Data Saved to Firestore!");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Account Created Successfully!")),
      );

      nameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneController.clear();

    } on FirebaseAuthException catch (e) {
      print("❌ FirebaseAuth Error: ${e.code}");

      String errorMessage = "An error occurred.";
      if (e.code == 'weak-password') {
        errorMessage = "The password is too weak.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "This email is already in use.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "Invalid email format.";
      } else {
        errorMessage = e.message ?? "Something went wrong.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print("❌ Unexpected Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create an account!")),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
           
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signUpUser,
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
