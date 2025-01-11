import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_auth/screens/home_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verifiyId;
  const OtpVerificationScreen({super.key, required this.verifiyId});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* --------------- OTP TextField -------------- */
          TextField(
            controller: otpController,
            decoration: InputDecoration(
              labelText: "OTP",
              hintText: "Enter your OTP",
              prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
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
            style: TextStyle(
                fontSize: 16.0, color: Colors.black, letterSpacing: 2.0),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            maxLength: 6,
            obscureText: true,
          ),
          SizedBox(height: 20),
          /* ----------- OTP BUTTON --------------*/
          SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              onPressed: verifyOTP,
              child: Text("Verify OTP"),
            ),
          ),
        ],
      ),
    );
  }

  // Function to verify OTP
  void verifyOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verifiyId,
        smsCode: otpController.text,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("User signed in: ${FirebaseAuth.instance.currentUser}");

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("OTP Verified",
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text("You have successfully verified your phone number.",
                textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (route) => false, // This removes all the previous routes
                  );
                  // Close the dialog
                },
                child: Text("OK", style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error verifying OTP: $e");
      // Show error dialog if OTP verification fails
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Verification Failed",
                style: TextStyle(fontWeight: FontWeight.bold)),
            content: Text("Failed to verify OTP. Please try again.",
                textAlign: TextAlign.center),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text("OK", style: TextStyle(color: Colors.blue)),
              ),
            ],
          );
        },
      );
    }
  }
}
