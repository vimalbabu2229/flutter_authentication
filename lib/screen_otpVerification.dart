import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import './screen_authenticate.dart';

class OTPVerificationScreen extends StatefulWidget {
  OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final FocusNode _pinputFocus = FocusNode();
  final FirebaseAuth auth = FirebaseAuth.instance;
  var smsCode = '';

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_pinputFocus);
    double screenWidth = MediaQuery.of(context).size.width;
    PinTheme defaultPinTheme = PinTheme(
        width: (screenWidth - 110) / 6,
        height: 60,
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 2,
          color: Colors.white,
        ))),
        textStyle: const TextStyle(
          fontSize: 30,
          color: Colors.white,
        ));
    PinTheme focusedPinTheme = defaultPinTheme.copyBorderWith(
        border: const Border(
      bottom: BorderSide(width: 2, color: Color.fromARGB(255, 41, 149, 203)),
    ));
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  color: const Color.fromARGB(38, 255, 255, 255),
                  alignment: const Alignment(0.4, 0),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Verification Code',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please type the verification code send to <number>',
              style: TextStyle(
                color: Colors.white24,
                fontSize: 18,
              ),
            ),
            // Expanded(child: SizedBox()),
            const SizedBox(
              height: 60,
            ),
            /**Pinput */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme.copyWith(),
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: focusedPinTheme,
                  onCompleted: (pin) => print(pin),
                  focusNode: _pinputFocus,
                  onChanged: (value) {
                    smsCode = value;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            /**Continue Button */
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 2, 85, 193),
                      Color.fromARGB(255, 1, 50, 123)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                child: ElevatedButton(
                  onPressed: () async {
                    //Once the profile screen is reached the user will need
                    //no to go back to the previous pages
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: AuthScreen.verificationId,
                            smsCode: smsCode);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'createProfile', (route) => route == null);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    //for the DecoratedBox to get worked the bgColor should be
                    //set as transparent
                    minimumSize: const Size(double.infinity, 0),
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text('Resend Code ?',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600))),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
