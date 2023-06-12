import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; //for importing svg images
import 'screen_authenticate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            padding: EdgeInsets.only(bottom: 100),
            // color: Color(0xFF091638),
            alignment: const Alignment(0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "ARROW",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                  ),
                ),
                const Text("target your fashion",
                    style: TextStyle(
                      color: Color.fromARGB(175, 104, 130, 196),
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: FloatingActionButton(
                // backgroundColor: Color.fromARGB(255, 2, 67, 151),
                onPressed: () {
                  Navigator.pushNamed(context, 'auth');
                },
                child: Container(
                  alignment: const Alignment(0, 0),
                  // width: 40,
                  // height: 40,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(101, 0, 0, 0),
                          offset: Offset(3, 3),
                          // spreadRadius: 4,
                          blurRadius: 15,
                        )
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 2, 85, 193),
                            Color.fromARGB(255, 1, 18, 43)
                          ])),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
