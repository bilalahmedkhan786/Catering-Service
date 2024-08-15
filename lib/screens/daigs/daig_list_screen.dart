import 'package:catering_service_manager/models/daig_model.dart';
import 'package:catering_service_manager/screens/daigs/add_daig_screen.dart';
import 'package:catering_service_manager/screens/daigs/update_daig_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DaigListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daig Inventory Management'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('daigs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          List<Daig> daigList = snapshot.data!.docs
              .map((doc) => Daig.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: daigList.length,
            itemBuilder: (context, index) {
              Daig daig = daigList[index];
              return ListTile(
                title: Text(daig.name),
                subtitle:
                    Text('Quantity: ${daig.quantity} | Status: ${daig.status}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateDaigScreen(daig: daig),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => deleteDaig(daig.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDaigScreen()),
          );
        },
      ),
    );
  }

  void deleteDaig(String daigId) async {
    await FirebaseFirestore.instance.collection('daigs').doc(daigId).delete();
  }
}
