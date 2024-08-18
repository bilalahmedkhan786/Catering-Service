import 'package:catering_service_manager/models/daig_model.dart';
import 'package:catering_service_manager/screens/daigs/daig_list_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widegts/customButton.dart';

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
  late String allocatedTo;

  final List<String> statusOptions = ['Pending', 'In Progress', 'Completed'];
  final List<String> allocatedOptions = [
    'Unassigned',
    'Chef',
    'Helper',
    'Manager'
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.daig.name);
    quantityController =
        TextEditingController(text: widget.daig.quantity.toString());
    status = widget.daig.status;
    allocatedTo = widget.daig.allocatedTo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(DaigListScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFF53B175),
        title: const Text(
          'Update Daig',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Daig Name',
                  border: UnderlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: UnderlineInputBorder(
                    borderSide: const BorderSide(
                        style: BorderStyle.solid, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: statusOptions.contains(status) ? status : null,
                onChanged: (newValue) {
                  setState(() {
                    status = newValue!;
                  });
                },
                items:
                    statusOptions.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              DropdownButton<String>(
                value:
                    allocatedOptions.contains(allocatedTo) ? allocatedTo : null,
                onChanged: (newValue) {
                  setState(() {
                    allocatedTo = newValue!;
                  });
                },
                items: allocatedOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              MyButton(
                  text: "Update Daig",
                  onPressed: () {
                    onUpdateDaig();
                     FirebaseMessaging messaging = FirebaseMessaging.instance;

                  }),
            ],
          ),
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
      allocatedTo: allocatedTo,
      dateAllocated: DateTime.now(),
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
