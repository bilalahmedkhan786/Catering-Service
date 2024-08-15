import 'package:catering_service_manager/models/daig_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDaigScreen extends StatefulWidget {
  @override
  _AddDaigScreenState createState() => _AddDaigScreenState();
}

class _AddDaigScreenState extends State<AddDaigScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Daig'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Daig Name'),
            ),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onAddDaig,
              child: Text('Add Daig'),
            ),
          ],
        ),
      ),
    );
  }

  void onAddDaig() {
    String id = FirebaseFirestore.instance.collection('daigs').doc().id;
    String name = nameController.text;
    int quantity = int.parse(quantityController.text);

    Daig newDaig = Daig(
      id: id,
      name: name,
      quantity: quantity,
      status: 'Pending',
    );

    addDaig(newDaig);
    Navigator.pop(context);
  }

  void addDaig(Daig daig) async {
    await FirebaseFirestore.instance.collection('daigs').doc(daig.id).set(daig.toMap());
  }
}
