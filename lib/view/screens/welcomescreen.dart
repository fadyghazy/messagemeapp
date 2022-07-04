import 'package:flutter/material.dart';
import 'package:messagemeproject/view/screens/signinscreen.dart';

import '../../widgets/mybutton.dart';
import 'registerationscreen.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.stretch ,
          children: [
            Image.asset("assets/images.png",height: 120),
            SizedBox(height: 10),
            Text("MessageMe",style: TextStyle(fontSize: 20,color: Colors.indigo[400]),textAlign: TextAlign.center,),
            SizedBox(height: 20),
            MyButton(color:Colors.yellow[900]!, text: 'SignIn', onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInScreen()));
            },

            ),
            SizedBox(height:10),
            MyButton(color:Colors.indigo[800]!, text: 'Register', onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>RegisterationScreen()));
            },

            ),




          ],
        ),
      ),
    );
  }
}
