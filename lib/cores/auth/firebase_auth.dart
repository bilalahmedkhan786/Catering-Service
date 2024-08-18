import 'package:catering_service_manager/pages/login.dart';
import 'package:catering_service_manager/screens/daigs/daig_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      Get.snackbar('Success', 'Account created successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Sign In
  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully!',
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.offAll(DaigListScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAll(const LoginScreen());
  }

  //Forget Password
  Future<void> forgetPassword(String myemail) async {
    _auth.sendPasswordResetEmail(email: myemail);
    Get.snackbar('Forget Password', 'Email Sent Successfully!',
        backgroundColor: Colors.green, colorText: Colors.white);
  }
}
