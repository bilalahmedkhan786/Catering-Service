import 'package:catering_service_manager/models/daig_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateDaigScreen extends StatefulWidget {
  final Daig daig;

  UpdateDaigScreen({required this.daig});

  @override
  _UpdateDaigScreenState createState() => _UpdateDaigScreenState();
}

class _UpdateDaigScreenState extends State<UpdateDaigScreen> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late String status;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.daig.name);
    quantityController =
        TextEditingController(text: widget.daig.quantity.toString());
    status = widget.daig.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Daig'),
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
            DropdownButton<String>(
              value: status,
              onChanged: (newValue) {
                setState(() {
                  status = newValue!;
                });
              },
              items: ['Pending', 'In Progress', 'Completed']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onUpdateDaig,
              child: Text('Update Daig'),
            ),
          ],
        ),
      ),
    );
  }

  void onUpdateDaig() {
    Daig updatedDaig = Daig(
      id: widget.daig.id,
      name: nameController.text,
      quantity: int.parse(quantityController.text),
      status: status,
    );

    updateDaig(updatedDaig);
    Navigator.pop(context);
  }

  void updateDaig(Daig updatedDaig) async {
    await FirebaseFirestore.instance
        .collection('daigs')
        .doc(updatedDaig.id)
        .update(updatedDaig.toMap());
  }
}
