import 'package:flutter/material.dart';
import 'package:messagemeproject/widgets/mybutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/messageline.dart';
class ChatScreen extends StatefulWidget {

const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 String? messagetext;
 final _firestore=FirebaseFirestore.instance;
  TextEditingController messageTextController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  late User signedInUser;

  void getCurrentUser(){
    try {
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        print(signedInUser.email);
      }
    }
    catch(e){
      print(e);
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        actions: [
          IconButton(onPressed: ()async{
            await _auth.signOut();
            Navigator.pop(context);
          }, icon:Icon(Icons.logout))
          
        ],

        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back),),

        title: Row(

          children: [
            Image.asset("assets/1646842.png",width:30),
            SizedBox(width: 10),
            Text("Chat",style: TextStyle(color: Colors.white,fontSize:30)),

          ],
        ),


      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          StreamBuilder<QuerySnapshot>(
             stream: _firestore.collection("messages").orderBy("time").snapshots(),
              builder:(context,snapshot){
               List<MessageLine>messageWidgets=[];
                if(!snapshot.hasData){
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.indigo,
                    ),
                  );
                }
                final messages=snapshot.data!.docs.reversed;
                for(var message in messages){
                  final  messageText =message.get('text');
                  final  messageSender=message.get('sender');
                  final  currentuser=signedInUser.email;
                  final messageWidget=MessageLine(text: messageText,sender: messageSender,isMe:currentuser==messageSender,);
                  messageWidgets.add(messageWidget);
                }
               return
                   Expanded(
                     child: ListView(
                      reverse: true,
                       children:messageWidgets
                     ),
                   );
              },
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType:TextInputType.emailAddress,
                    autofocus: true,
                    controller: messageTextController,
                    cursorColor: Colors.indigo,
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      messagetext=value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your message here",
                        hintStyle: TextStyle(color: Colors.black),
                        label: Text("message",style: TextStyle(fontSize: 8),
                        ),
                        contentPadding:EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.lightBlue,
                        suffixIcon:Icon(Icons.message,color: Colors.teal),
                        disabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2,color: Colors.lightBlue),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 1,color: Colors.deepPurple),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 3,color: Colors.lightBlueAccent),

                        )

                    ),

                  ),

                ),
                MyButton(color: Colors.indigoAccent,text: "Send",onPressed: ()async{
                  messageTextController.clear();
                 final messages= await _firestore.collection("messages").add({
                   "text":messagetext,"sender":signedInUser.email,
                   "time":FieldValue.serverTimestamp()
                 });

                },)
              ],

            ),
          )
        ],
      ),

    );
  }
}
