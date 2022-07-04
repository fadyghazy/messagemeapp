
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
 final String text;
 final  Color color ;
 final Function()onPressed;
  MyButton({required this.text,required this.color,required this.onPressed});
  @override
  Widget build(BuildContext context) {

    return TextButton(onPressed:onPressed, child:Text(text,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
        ,style: TextButton.styleFrom(
            backgroundColor:color,
            primary: Colors.white,elevation: 5),);

  }
}
