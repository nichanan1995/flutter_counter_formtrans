import 'package:flutter/material.dart';
import 'screens/register.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import './models/json_model.dart';
import 'dart:convert';
void main() {
 runApp(App());
}

class App extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'Sun Authen',
     home: HomePage(),
   );
 }
}

class HomePage extends StatefulWidget {
 @override
 _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 final formKey = GlobalKey<FormState>();
 final _scaffold = GlobalKey<ScaffoldState>();

 String barcode = "";

 @override
 Widget build(BuildContext context) {
   return Scaffold(
     key: _scaffold,
     appBar: AppBar(
       title: Text('QR Counter'),
      //  actions: <Widget>[IconButton(tooltip: 'upload',
      //    icon: Icon(Icons.cloud_upload),onPressed: (){},)],
     ),
     body: Form(
       key: formKey,
       child: ListView(
         children: <Widget>[


           Container(
             margin: EdgeInsets.only(left: 50.0, right: 50.0),
             child: Row(
               children: <Widget>[
                 new Expanded(
                   child: signUpButton(context),
                 ),
                 //new Expanded(child: Container(child: testText(),)
               ],
             ),
           ),

           Text(barcode),

         ],
       ),
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: scan,
         child: Icon(Icons.add_a_photo)),


   );


 }

 Widget signUpButton(BuildContext context) {
   return RaisedButton(
     color: Colors.orange,
     child: Text(
       'confirm',
       style: TextStyle(color: Colors.white),
     ),
     onPressed: () {
       print('your click SignIn');
       var myRounte = new MaterialPageRoute(
           builder: (BuildContext context) => Register());
       Navigator.of(context).push(myRounte);
     },
   );
 }

 Future sendtoserver(data) async {
   print('============');
   print(data);
   print('============');

   var url = 'http://androidthai.in.th/sun/addDataOill.php';
   var response = await http.post(url, body: {'isAdd': 'true', 'Barcode': data});
   print('Response status: ${response.statusCode}');
   print('Response body: ${response.body}');
 }

 Future scan() async {
   try {
     String barcode = await BarcodeScanner.scan();
     setState(() => this.barcode = barcode);

     sendtoserver(this.barcode);
   } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
   } catch (e) {
     setState(() => this.barcode = 'Unknown error: $e');
   }
 }


} //_HomePageState



