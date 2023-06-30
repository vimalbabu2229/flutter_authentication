// ignore: slash_for_doc_comments
/**
 * Platform  Firebase App Id
web       1:942823924996:web:de3ad57bdbaf7432f89c51
android   1:942823924996:android:4f67d9dcaf28637af89c51
ios       1:942823924996:ios:9b79c747f7202874f89c51
macos     1:942823924996:ios:9b79c747f7202874f89c51
 */

//why removed windows , macos and linux
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screen_welcome.dart';
import 'screen_authenticate.dart';
import 'screen_otpVerification.dart';
import './screen_createProfile.dart' ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(Arrow());
}

class Arrow extends StatelessWidget {
  const Arrow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: (FirebaseAuth.instance.currentUser != null)?'createProfile':'welcome',
      routes: {
        'welcome': (context) => const WelcomeScreen(),
        'auth': (context) => AuthScreen(),
        'otpVerification': (context) => OTPVerificationScreen(),
        'createProfile': (context) => const CreateProfile(),
      },
      theme: ThemeData(
        fontFamily: 'Raleway',
        scaffoldBackgroundColor:  Color(0xFF091638),
      ),
      // home: const WelcomeScreen(),
    );
  }
}
