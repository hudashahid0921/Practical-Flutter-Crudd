import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _medicineDescController = TextEditingController();
  final TextEditingController _medicinePriceController = TextEditingController();
  final CollectionReference medicines = FirebaseFirestore.instance.collection('AddMedicine');
<<<<<<< HEAD
=======
  String? documentId;
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f

  bool _isLoading = false; // ✅ Loading state

  void _showAlert(String message, {bool shouldGoBack = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Alert"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (shouldGoBack) {
                  Navigator.pop(context);
                }
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

<<<<<<< HEAD
  Future<void> addMedicine() async {
    String medicineTitle = _medicineNameController.text.trim();
    String desc = _medicineDescController.text.trim();
    String priceText = _medicinePriceController.text.trim();

    if (medicineTitle.isEmpty || desc.isEmpty || priceText.isEmpty) {
      _showAlert("All fields are required!");
      return;
    }

    int? price = int.tryParse(priceText);
    if (price == null) {
      _showAlert("Invalid price! Enter a valid number.");
      return;
    }

    setState(() {
      _isLoading = true; // ✅ Start loading
    });

    try {
      await medicines.add({
        'Title': medicineTitle,
        'Description': desc,
        'Price': price
      });
=======
  Future<void> _loadMedicineData() async {
    DocumentSnapshot doc = await medicines.doc(documentId).get();
    if (doc.exists) {
      setState(() {
        _medicineNameController.text = doc["Title"];
        _medicineDescController.text = doc["Description"];
        _medicinePriceController.text = doc["Price"].toString();
      });
    }
  }

  Future<void> addOrUpdateMedicine() async {
    if (_medicineNameController.text.isEmpty ||
        _medicineDescController.text.isEmpty ||
        _medicinePriceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    int? price = int.tryParse(_medicinePriceController.text);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid price! Enter a valid number.")),
      );
      return;
    }

    if (documentId == null) {
      await medicines.add({
        'Title': _medicineNameController.text,
        'Description': _medicineDescController.text,
        'Price': price,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Medicine added successfully!")),
      );
    } else {
      await medicines.doc(documentId).update({
        'Title': _medicineNameController.text,
        'Description': _medicineDescController.text,
        'Price': price,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Medicine updated successfully!")),
      );
    }
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f

      _showAlert("Medicine added successfully!", shouldGoBack: true);
    } catch (error) {
      _showAlert("Failed to add medicine: $error");
    } finally {
      setState(() {
        _isLoading = false; // ✅ Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(title: const Text("Add Medicine")),
      body: Center(
        child: ListView(
=======
      appBar: AppBar(
        title: Text(documentId == null ? "Add Medicine" : "Update Medicine"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
>>>>>>> 0b67856da7036d02039369f6754004ec784a435f
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _medicineNameController,
                decoration: const InputDecoration(
                  labelText: "Medicine Name",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _medicineDescController,
                decoration: const InputDecoration(
                  labelText: "Medicine Description",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _medicinePriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Medicine Price",
                  border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator()) // ✅ Spinner dikhayega
                  : ElevatedButton(
                      onPressed: addMedicine, 
                      child: const Text("Add Medicine")
                    ),
            )
          ],
        ),
      ),
    );
  }
}
