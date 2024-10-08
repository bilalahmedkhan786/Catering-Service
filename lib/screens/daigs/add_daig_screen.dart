import 'package:catering_service_manager/models/daig_model.dart';
import 'package:catering_service_manager/screens/daigs/daig_list_screen.dart';
import 'package:catering_service_manager/shared/widegts/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDiagScreen extends StatefulWidget {
  @override
  _AddDiagScreenState createState() => _AddDiagScreenState();
}

class _AddDiagScreenState extends State<AddDiagScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String allocatedTo = 'Unassigned';

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
          'Add Daig',
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
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Quantity',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        style: BorderStyle.solid, color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              DropdownButton<String>(
                value: allocatedTo,
                onChanged: (newValue) {
                  setState(() {
                    allocatedTo = newValue!;
                  });
                },
                items: ['Unassigned', 'Chef', 'Helper', 'Manager']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              MyButton(text: "Add Daig", onPressed: onAddDaig),
            ],
          ),
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
      allocatedTo: allocatedTo,
      dateAllocated: DateTime.now(),
    );

    addDaig(newDaig);
    Navigator.pop(context);
  }

  void addDaig(Daig daig) async {
    await FirebaseFirestore.instance
        .collection('daigs')
        .doc(daig.id)
        .set(daig.toMap());
  }
}
