import 'package:catcine_es/Auth/authmain.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  void _signIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthMainPage(pageSelector: true)
      ));
  }

  void _register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AuthMainPage(pageSelector: false)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: const Color(0xff393d5a),
        elevation: 0.0,
      ),
      body: Padding (
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/Initial.png'),
              SizedBox(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xFFEC6B76),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: _signIn,
                  child: const Text(
                      "Sign in" ,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 34.0),
              SizedBox(
                width:double.infinity,
                child: RawMaterialButton(
                  fillColor: const Color(0xBDD3D4FF),
                  elevation: 0.0,
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: _register,
                  child: const Text(
                    "Register" ,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}

