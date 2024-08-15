import 'package:catering_service_manager/models/daig_model.dart';
import 'package:catering_service_manager/screens/daigs/daig_list_screen.dart';
import 'package:catering_service_manager/shared/widegts/customButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                    borderRadius: BorderRadius.circular(8),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
