import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyMedicine extends StatefulWidget {
  const MyMedicine({super.key});

  @override
  State<MyMedicine> createState() => _MyMedicineState();
}

class _MyMedicineState extends State<MyMedicine> {
  Stream<QuerySnapshot> medicines =
      FirebaseFirestore.instance.collection("AddMedicine").snapshots(); // ✅ Correct database name

  void deleteMedicine(String documentId) async {
    await FirebaseFirestore.instance.collection('AddMedicine').doc(documentId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Medicine deleted successfully!")),
    );
  }

  void updateMedicine(String documentId) {
    Navigator.pushNamed(context, '/addmedicine', arguments: documentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Medicines", style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 35),
            onPressed: () => Navigator.pushNamed(context, "/addmedicine"),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: medicines,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.medical_services, color: Colors.blue, size: 30),
                  title: Text(doc["Title"], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doc["Description"], maxLines: 2, overflow: TextOverflow.ellipsis),
                      Text("\$${doc["Price"]}", style: const TextStyle(color: Colors.green)),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        onPressed: () => updateMedicine(doc.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteMedicine(doc.id),
                      ),
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