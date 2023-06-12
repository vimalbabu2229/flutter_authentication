import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'screen_otpVerification.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  String phone_number = "";
  static String verificationId = '';/**It is used to store the verification id 
  it can be directly called in the next screen , because it is static  */

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Scaffold(
        /**To avoid the elements to change the layout on opening the keyboard  */
        // resizeToAvoidBottomInset: false,
        body: Container(
          height: screenHeight - keyboardHeight,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              //find a better solution for the below issue of 150
              constraints: BoxConstraints(maxHeight: screenHeight - 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "ARROW",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Text field
                  Container(
                    width: double.infinity,
                    height: 110,
                    child: IntlPhoneField(
                      onChanged: (value) => phone_number = value.completeNumber,
                      validator: (phone) {
                        if (phone!.number.isEmpty) {
                          print("Please enter your number ");
                        }
                      },
                      showCountryFlag: false,
                      flagsButtonMargin: const EdgeInsets.only(right: 10),
                      dropdownDecoration: const BoxDecoration(
                        color: Color.fromARGB(255, 25, 56, 113),
                      ),
                      // inputFormatters: [
                      //   LengthLimitingTextInputFormatter(12),
                      //   MaskedInputFormatter('0000 000 000 000 ')
                      // ],
                      initialCountryCode: "IN",
                      dropdownTextStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        letterSpacing: 5,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          letterSpacing: 2,
                          fontSize: 16,
                          color: Color.fromARGB(255, 145, 145, 145),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 25, 56, 113),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 25, 56, 113),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 25, 56, 113),
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Button
                  Column(
                    children: [
                      DecoratedBox(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 2, 85, 193),
                                  Color.fromARGB(255, 1, 50, 123)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: ElevatedButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: phone_number,
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                AuthScreen.verificationId = verificationId; 
                                /**For accessing the verification id form the next screen  */
                                Navigator.pushNamed(context, 'otpVerification');
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            //for the DecoratedBox to get worked the bgColor should be
                            //set as transparent
                            minimumSize: const Size(double.infinity, 0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 0),
                          ),
                          child: const Text(
                            "Get OTP",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(fontSize: 12),
                          children: [
                            TextSpan(
                                text: "By clicking you are agreeing our",
                                style: TextStyle(
                                  color: Color.fromARGB(130, 255, 255, 255),
                                )),
                            TextSpan(
                                text: " \nTerms",
                                style: TextStyle(
                                  color: Color.fromARGB(170, 3, 111, 252),
                                  fontSize: 14,
                                )),
                            TextSpan(
                                text: " and",
                                style: TextStyle(
                                  color: Color.fromARGB(130, 255, 255, 255),
                                )),
                            TextSpan(
                                text: " Conditions",
                                style: TextStyle(
                                  color: Color.fromARGB(170, 3, 111, 252),
                                  fontSize: 14,
                                )),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
