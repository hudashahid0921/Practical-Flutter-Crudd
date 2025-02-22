import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

<<<<<<< HEAD
  Future<void> signUpUser() async {
=======
  signUpUser() async {
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

<<<<<<< HEAD
=======
    // Validate input fields
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

<<<<<<< HEAD
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
=======
    // Basic email validation
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address!")),
      );
      return;
    }

    try {
<<<<<<< HEAD
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
=======
      // Create user with email and password
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
        email: email,
        password: password,
      );

<<<<<<< HEAD
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
=======
      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
        'name': name,
        'email': email,
      });

<<<<<<< HEAD
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Account Created Successfully!")),
      );

      // Navigate to Login Page
      Navigator.pushReplacementNamed(context, '/login');

      nameController.clear();
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Signup failed. Please try again.";
      if (e.code == 'weak-password') {
        errorMessage = "The password is too weak.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
=======
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User Account Created")),
      );

      // Clear input fields
      nameController.clear();
      emailController.clear();
      passwordController.clear();

      // Navigate to login screen
      Navigator.pushNamed(context, '/login');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The password provided is too weak.")),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("The account already exists for that email.")),
        );
      }
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
    } catch (e) {
      print(e);
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
<<<<<<< HEAD
=======
            // Name input field
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
<<<<<<< HEAD
=======

            // Email input field
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
<<<<<<< HEAD
=======

            // Password input field
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
<<<<<<< HEAD
            ElevatedButton(
              onPressed: signUpUser,
              child: const Text("Sign Up"),
            ),
=======

            // Sign-up button
            ElevatedButton(
              onPressed: () {
                signUpUser();
              },
              child: const Text("Sign Up"),
            ),

            // Link to Login page
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}

<<<<<<< HEAD
// --------------------------- LOGIN SCREEN ---------------------------

=======
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
<<<<<<< HEAD
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

=======
    String email = emailController.text;
    String password = passwordController.text;

    // Validate input fields
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

<<<<<<< HEAD
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email format!")),
=======
    // Basic email validation
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email address!")),
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
      );
      return;
    }

    try {
<<<<<<< HEAD
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful!")),
      );

      // Navigate to Medicine Screen
      Navigator.pushReplacementNamed(context, '/MedicineScreen');
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found with this email!";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect password!";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      print("Login error: $e");
=======
      var signInWithEmailAndPassword = FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userCredential =
          await signInWithEmailAndPassword;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Successful!")));
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found for that email.")),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong password provided.")),
        );
      }
    } catch (e) {
      print(e);
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
<<<<<<< HEAD
=======
            // Email input field
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
<<<<<<< HEAD
=======

            // Password input field
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
<<<<<<< HEAD
            ElevatedButton(
              onPressed: loginUser,
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Signup');
=======

            // Login button
            ElevatedButton(
              onPressed: () {
                loginUser();
              },
              child: const Text("Login"),
            ),

            // Link to Signup page
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
