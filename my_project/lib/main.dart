import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_project/addmedicine.dart';
import 'package:my_project/auth.dart';
import 'package:my_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/addmedicine.dart';
import 'package:my_project/auth.dart';
import 'package:my_project/firebase_options.dart';
import 'package:my_project/medicine.dart'; 
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
<<<<<<< HEAD
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
=======
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      title: 'Medicine App',
=======
      title: 'Medicine',
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
<<<<<<< HEAD
      home: Signup(),
      routes: {
        '/addmedicine': (context) => const AddMedicine(),
        '/login': (context) => const Login(),
        '/MedicineScreen': (context) => const MedicineScreen(),
        '/Signup': (context) => const Signup(),
=======
      debugShowCheckedModeBanner: false,

      // Home screen (initial screen when app starts)
      home: FirebaseAuth.instance.currentUser == null ? Signup() : MyMedicine(),

      // Routes setup
      routes: {
        '/addmedicine': (context) => const AddMedicine(),
         '/login': (context) => const Login(),
        '/home': (context) => const MyMedicine(), // Home screen after login
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
      },
    );
  }
}

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({super.key});

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('AddMedicine');

  String userName = "Loading...";
  String userEmail = "Loading...";
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String uid = currentUser!.uid;

        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          setState(() {
            userName = userDoc['name'] ?? "Unknown User";
            userEmail = userDoc['email'] ?? "No Email";
          });
        } else {
          setState(() {
            userName = "Unknown User";
            userEmail = "No Email";
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        userName = "Error loading user";
        userEmail = "Error";
      });
    }
  }

  void _showUserProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("User Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_circle, size: 50, color: Colors.blue),
              const SizedBox(height: 10),
              Text("Name: $userName",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Email: $userEmail"),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMedicineDetails(String title, dynamic description, dynamic price) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description: ${description.toString()}"),
              const SizedBox(height: 10),
              Text("Price: ${price.toString()}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _editMedicineDialog(
      String docId, String title, String description, String price) {
    TextEditingController titleController =
        TextEditingController(text: title);
    TextEditingController descriptionController =
        TextEditingController(text: description);
    TextEditingController priceController =
        TextEditingController(text: price);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Medicine"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('AddMedicine')
                    .doc(docId)
                    .update({
                  'Title': titleController.text.trim(),
                  'Description': descriptionController.text.trim(),
                  'Price': priceController.text.trim(),
                });

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Medicine Updated Successfully!")),
                );
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Available Medicines", style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 30),
            onPressed: () {
              Navigator.pushNamed(context, '/addmedicine');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, size: 35),
            onPressed: _showUserProfile,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: medicineCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SpinKitDancingSquare(color: Colors.blueAccent));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No medicines available!"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.medication,
                      color: Colors.blue, size: 30),
                  title: Text(doc['Title'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(doc['Description'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.info, color: Colors.green),
                          onPressed: () => _showMedicineDetails(
                              doc['Title'], doc['Description'], doc['Price'].toString())),
                      IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _editMedicineDialog(
                              doc.id, doc['Title'], doc['Description'], doc['Price'].toString())),
                      IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              medicineCollection.doc(doc.id).delete()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
