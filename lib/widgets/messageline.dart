import 'package:flutter/material.dart';
class MessageLine extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  const MessageLine({
    Key? key,
    required this.text,
    required this.sender,
    required this.isMe,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text("${sender}",style: TextStyle(fontSize:10,color:isMe? Colors.lightBlue:Colors.purpleAccent),),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal:10),
          child: Material(

            elevation: 5,
            borderRadius:isMe?BorderRadius.only
              (topLeft:Radius.circular(30),
              bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30),

            ):BorderRadius.only
              (topRight:Radius.circular(30),
              bottomLeft:Radius.circular(30),bottomRight:Radius.circular(30),

            ),
            color:isMe? Colors.indigo[400]:Colors.blue,
            child: Text("$text",style: TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),),


          ),
        ),
      ],
    );
  }
}
