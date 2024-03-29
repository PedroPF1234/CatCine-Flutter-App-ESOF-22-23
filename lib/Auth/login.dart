import 'package:catcine_es/Model/media.dart';
import 'package:catcine_es/Pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginUsingEmailPassword() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      user = userCredential.user;
      if (user != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const Home()));

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
    } on FirebaseAuthException catch (exception) {
      if (exception.code == "user-not-found") {
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
                        "This User Does Not Exist",
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
      if (exception.code == "wrong-password") {
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
                        "Wrong Password!",
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff393d5a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'images/WelcomeBack.png',
                width: width/1.09,
                height: height/1.74,
                fit: BoxFit.cover,
              ),
            ),
            Padding (
                padding: EdgeInsets.symmetric(horizontal: width/25.72),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height/3.47),

                    TextField(
                      key: const Key("emailKey"),
                      controller: emailController,
                      autocorrect: false,
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
                    SizedBox(height: height/33.37),

                    TextField(
                      key: const Key("passwordKey"),
                      controller: passwordController,
                      autocorrect: false,
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
                    SizedBox( height: height/33.37),

                    SizedBox(
                      key: const Key("loginButton"),
                      width:double.infinity,
                      child: RawMaterialButton(
                        fillColor: const Color(0xFFEC6B76),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 0.0,
                        padding: EdgeInsets.symmetric(vertical: height/43.38),
                        onPressed: () async {
                          loginUsingEmailPassword();
                        },
                        child: const Text(
                          "Sign in" ,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: height/43.38),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("I'm a new user!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                            onTap: widget.showRegisterPage,
                            child: const Text(
                              "Register Now",
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
                )
            ),
          ],
        ),
      ),
    );
  }
}
