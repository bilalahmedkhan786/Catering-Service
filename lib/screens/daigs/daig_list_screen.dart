import 'package:catering_service_manager/cores/auth/firebase_auth.dart';
import 'package:catering_service_manager/cores/services/notification_service.dart';
import 'package:catering_service_manager/models/daig_model.dart';
import 'package:catering_service_manager/screens/daigs/add_daig_screen.dart';
import 'package:catering_service_manager/screens/daigs/update_daig_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DaigListScreen extends StatefulWidget {
  @override
  State<DaigListScreen> createState() => _DaigListScreenState();
}

class _DaigListScreenState extends State<DaigListScreen> {
  Auth myauth = Auth();
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then(
      (value) {
        print('device token');
        print(value);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF53B175),
        title: const Center(
          child: Text(
            'Daig Management',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                myauth.signOut();
                Get.snackbar('Success', 'Logout successfully!',
                    backgroundColor: Colors.green, colorText: Colors.white);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('daigs').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return const Center(child: CircularProgressIndicator());

            List<Daig> daigList = snapshot.data!.docs
                .map((doc) => Daig.fromMap(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.builder(
              itemCount: daigList.length,
              itemBuilder: (context, index) {
                Daig daig = daigList[index];
                return ListTile(
                  title: Text(daig.name),
                  subtitle: Text(
                    'Quantity: ${daig.quantity} | Status: ${daig.status}\nAllocated To: ${daig.allocatedTo} | Date: ${DateFormat('yyyy-MM-dd').format(daig.dateAllocated)}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.lightGreen,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UpdateDaigScreen(daig: daig),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => deleteDaig(daig.id),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF53B175),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDiagScreen()),
          );
        },
      ),
    );
  }

  void deleteDaig(String daigId) async {
    await FirebaseFirestore.instance.collection('daigs').doc(daigId).delete();
  }
}
