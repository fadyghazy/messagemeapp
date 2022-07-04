import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widgets/mybutton.dart';
import 'chatscreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: (
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images.png", height: 120,),
                  SizedBox(height: 30,),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    controller: emailController,
                    cursorColor: Colors.indigo,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      emailController != value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter email",
                        hintStyle: TextStyle(color: Colors.black),
                        label: Text("email", style: TextStyle(fontSize: 10),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.lightBlue,
                        suffixIcon: Icon(Icons.email, color: Colors.teal),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2, color: Colors.lightBlue),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 3, color: Colors.lightBlueAccent),

                        )

                    ),

                  ),
                  SizedBox(height: 10),
                  TextField(
                    obscureText: true,
                    autofocus: true,
                    controller: passwordController,
                    cursorColor: Colors.indigo,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      passwordController != value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter password",
                        hintStyle: TextStyle(color: Colors.black),
                        label: Text("Password", style: TextStyle(fontSize: 8),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.lightBlue,
                        suffixIcon: Icon(Icons.lock, color: Colors.teal),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 2, color: Colors.lightBlue),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1, color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              width: 3, color: Colors.lightBlueAccent),

                        )

                    ),

                  ),
                  SizedBox(height: 20,),
                  MyButton(onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth.signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                      if (user != null) {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreen()));
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    }
                    catch (e) {
                      print(e);
                    }
                  }, text: 'SignIn', color: Colors.indigo,)


                ],
              )
          ),
        ),
      ),
    );
  }
}

