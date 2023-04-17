// ignore_for_file: use_build_context_synchronously

import 'package:catcine_es/Auth/authinitial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool passwordConfirmed() {
    return (passwordController.text.trim() == confirmPasswordController.text.trim());
  }

  Future signUp() async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim()
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const MainPage()
            )
        );
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  alignment: Alignment.topCenter,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  backgroundColor: Colors.green,
                  content:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.check,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Success!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
              );
            }
        );
      }
      else {
        throw const FormatException("passwords-not-matching");
      }
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "email-already-in-use") {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  alignment: Alignment.topCenter,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 87, 51),
                  content:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "This Email is already in use",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
              );
            }
        );
      }
      if (exception.code == "weak-password") {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  alignment: Alignment.topCenter,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 87, 51),
                  content:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Weak Password!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
              );
            }
        );
      }
      if (exception.code == "invalid-email") {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  alignment: Alignment.topCenter,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 87, 51),
                  content:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Invalid Email!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
              );
            }
        );
      }
    } on FormatException catch (exception) {
      if(exception.message == "passwords-not-matching") {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  alignment: Alignment.topCenter,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  backgroundColor: const Color.fromARGB(255, 255, 87, 51),
                  content:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Passwords Not Matching!",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),
                      ),
                    ],
                  )
              );
            }
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: const Color(0xff393d5a),
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            child: Image.asset(
              'images/CreateAccount.png',
              width: 380,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
       Padding (
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 200),

                TextField(
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: " Enter your catname",
                  ),
                ),
                const SizedBox(height: 26.0),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: " Enter your email",
                  ),
                ),
                const SizedBox(height: 26.0),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: " Enter your password",
                  ),
                ),
                const SizedBox(height: 26.0),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled:true,
                    fillColor: const Color(0xFFFFFFFF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: " Confirm your password",
                  ),
                ),
                const SizedBox(height: 34.0),

                SizedBox(
                  width:double.infinity,
                  child: RawMaterialButton(
                    fillColor: const Color(0xFFEC6B76),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      signUp();
                    },
                    child: const Text(
                        "Register" ,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        )
                    )
                  ],
                )
              ],
            ),
          )
      ),
    ],
    ),
    );
  }
}