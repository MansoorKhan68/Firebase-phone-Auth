// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/otp_verification_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Phone Authentication")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone Number",
                hintText: "Enter your phone number",
                prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
               
                prefixStyle: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
              ),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            SizedBox(
              //SEND OTP BUTTON
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
                onPressed: sendOTP,
                child: Text("Send OTP"),
              ),
            ),
            SizedBox(height: 40),

          ],
        ),
      ),
    );
  }

  // Function to send OTP
  void sendOTP() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (PhoneAuthCredential credential) async {
        
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> OtpVerificationScreen(verifiyId: verificationId)));
          
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("Code auto-retrieval timeout");
        },
      );
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

 
}
