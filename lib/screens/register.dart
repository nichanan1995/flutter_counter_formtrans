import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import '../main.dart';

class Register extends StatefulWidget {
 final Widget child;

 Register({Key key, this.child}) : super(key: key);

 _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
 final formKey = GlobalKey<FormState>();
 String licenString = '';
 String transString = '';
 String nameString = '';

 @override
 Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
         title: Text('Confirm'),
         actions: <Widget>[
           IconButton(
             tooltip: 'Upload To Server',
             icon: Icon(Icons.cloud_upload),
             onPressed: () {
               uploadToServer();
             },
           )
         ],
       ),
       body: Form(
         key: formKey,
         child: ListView(
           children: <Widget>[
             Container(
               margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
               child: licenTextField(),
             ),
             Container(
               margin: EdgeInsets.only(left: 50.0, right: 50.0),
               child: transTextField(),
             ),
             Container(
               margin: EdgeInsets.only(left: 50.0, right: 50.0),
               child: nameTextField(),
             )
           ],
         ),
       ));
 }

 void uploadToServer() {
//    String licenString = '';
//  String transString = '';
//  String nameString = '';
   print('You Click Upload');
   // formKey.currentState.reset();
   print(formKey.currentState.validate());
   formKey.currentState.save();
   print('Licen = $licenString, Trans = $transString, Name = $nameString');
   sentNewUserToServer(licenString, transString, nameString);
   
 }

 void sentNewUserToServer(
  String userLicen, String userTrans, String userName) async {
    print('Licen = $userLicen, Trans = $userTrans, Name = $userName');
  String url ='http://androidthai.in.th/sun/addUserOil.php?isAdd=true&Licen=$userLicen&Trans=$userTrans&Name=$userName';
   print(url);
   var respone = await get(url);
   print(respone);
   var result = json.decode(respone.body);
   print(result);
   print('result ==>$result');
   if (result.toString() == 'true') {

     print('back process');
     Navigator.pop(context);

     //var backRount =new MaterialPageRoute(builder: (BuildContext )=> HomePage());
      //Navigator.of(context).push(backRount);

   }
 }

 Widget licenTextField() {
   return TextFormField(
     decoration: InputDecoration(labelText: 'licen:', hintText: 'Name Only'),
     validator: (String value) {
       if (value.length == 0) {
         return 'licen not Blank ?';
       }
     },
     onSaved: (String licen) {
       licenString = licen;
     },
   );
 }
Widget transTextField() {
   return TextFormField(
     decoration: InputDecoration(labelText: 'trans:', hintText: 'Name Only'),
     validator: (String value) {
       if (value.length == 0) {
         return 'trans not Blank ?';
       }
     },
     onSaved: (String trans) {
       transString = trans;
     },
   );
 }

 Widget nameTextField() {
   return TextFormField(
     decoration: InputDecoration(labelText: 'Name:', hintText: 'Name Only'),
     validator: (String value) {
       if (value.length == 0) {
         return 'name not Blank ?';
       }
     },
     onSaved: (String name) {
       nameString = name;
     },
   );
 }
}

