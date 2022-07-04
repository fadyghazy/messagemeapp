import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messagemeproject/view/screens/chatscreen.dart';
import 'package:messagemeproject/widgets/mybutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterationScreen extends StatefulWidget {

  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  final _auth=FirebaseAuth.instance;
   bool ShowSpinner =false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: ShowSpinner,
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images.png",height: 120,),
              SizedBox(height: 20,),
              TextField(
                keyboardType:TextInputType.emailAddress,
                autofocus: true,
                controller: emailController,
                cursorColor: Colors.indigo,
                textAlign: TextAlign.center,
                onChanged: (value){
                  emailController!=value;
                },
                decoration: InputDecoration(
                  hintText: "Enter email",
                  hintStyle: TextStyle(fontSize: 10,color: Colors.black),
                  label: Text("email",style: TextStyle(fontSize: 8),
                  ),
                  contentPadding:EdgeInsets.symmetric(vertical: 10),
                  fillColor: Colors.lightBlue,
                  suffixIcon:Icon(Icons.email,color: Colors.teal),
                  disabledBorder:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 2,color: Colors.lightBlue),

                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 1,color: Colors.deepPurpleAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(width: 3,color: Colors.transparent),

                  )

                ),

              ),
              SizedBox(height:10),
              TextField(
                obscureText: true,
                autofocus: true,
                controller:passwordController,
                cursorColor: Colors.indigo,
                textAlign: TextAlign.center,
                onChanged: (value){
                  passwordController!=value;
                },
                decoration: InputDecoration(
                    hintText: "Enter password",
                    hintStyle: TextStyle(fontSize: 10,color: Colors.black),
                    label: Text("Password",style: TextStyle(fontSize: 8),
                    ),
                    contentPadding:EdgeInsets.symmetric(vertical: 10),
                    fillColor: Colors.lightBlue,
                    suffixIcon:Icon(Icons.lock,color: Colors.teal),
                    disabledBorder:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 2,color: Colors.lightBlue),

                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 1,color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 3,color: Colors.lightBlueAccent),

                    )

                ),

              ),
              MyButton(onPressed: ()async {
                setState(() {
                  ShowSpinner=true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                  setState(() {
                    ShowSpinner=false;
                  });
                }
                catch(e){
                  print(e);
                }
              }, text: 'Register', color: Colors.yellow[900]!,)


            ],
          ),
        ),
      ),
    );
  }
}
