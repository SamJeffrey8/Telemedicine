import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pharmacy_app1/pages/locationsearch_page.dart';
import 'package:pharmacy_app1/pages/medication_page.dart';
import 'package:pharmacy_app1/pages/prescription_page.dart';


class PatientInfoPage extends StatefulWidget {
  final int userId, storeId;
  final String storeName, storeLocation, zipCode, storeEmail;
  PatientInfoPage({
   this.userId,
   this.storeId,
    this.storeName,
    this.storeLocation,
    this.zipCode,
    this.storeEmail,
});
  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {

  double _deviceHeight;
  double _deviceWidth;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _email = TextEditingController();



  bool isDateSelected= false;
  DateTime birthDate; // instance of DateTime
  String birthDateInString;



  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: new Text(value, style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.red,
      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF304FFE),
        title: Text('Patient Info'),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: _patientBooking(),
      ),

    );
  }

  Widget _patientBooking(){
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Store Name :'),
              Text(widget.storeName),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Location :'),
            Text(widget.storeLocation),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SearchLocationPage(),
                ));
              },
              child: Text('Change Location',
              style: TextStyle(
                color: Color(0xFF304FFE),
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            Icon(
              Icons.edit_location,
              size: 15,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('ZipCode :'),
              Text(widget.zipCode),
            ],
          ),
        ),

     Padding(
       padding:  EdgeInsets.only(top:70.0, left: 20, right: 20),
       child: Container(
         //height: _deviceHeight * 0.34,
         child: Card(
           child: Form(
             key: _formKey,
             onChanged: (){
               _formKey.currentState.save();
             },
             child: Column(
               children: <Widget>[
                 SizedBox(
                   height: 15,
                 ),
                 Text('Please enter following details',
                 style: TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.bold
                 ),
                 ),

                 ListTile(
                   leading: const Icon(
                     Icons.person,
                     color: Color(0xFF304FFE),
                   ),
                   title: new TextFormField(
                     controller: _firstName,
                     decoration: new InputDecoration(
                       hintText: "First name",
                     ),

                   ),
                 ),
                 new ListTile(

                   leading: const Icon(
                       Icons.person,
                     color: Color(0xFF304FFE),
                   ),
                   title: new TextFormField(
                    controller: _lastName,
                     decoration: new InputDecoration(
                       hintText: "Last name",
                     ),
                   ),
                 ),
                 new ListTile(
                   leading: const Icon(
                     Icons.email,
                     color: Color(0xFF304FFE),
                   ),
                   title: new TextFormField(
                    controller: _email,
                     decoration: new InputDecoration(
                       hintText: "Email",
                     ),
                   ),
                 ),


                 new ListTile(
                     onTap: ()async{
                       final datePick= await showDatePicker(
                           context: context,
                           initialDate: new DateTime.now(),
                           firstDate: new DateTime(1900),
                           lastDate: new DateTime(2100)
                       );
                       if(datePick!=null && datePick!=birthDate){
                         setState(() {
                           birthDate=datePick;
                           isDateSelected=true;
                           birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                         });
                       }
                     },
                   leading: const Icon(
                     Icons.today,
                     color: Color(0xFF304FFE),
                   ),
                   title: const Text('Birthday'),
                   subtitle: !isDateSelected ? Text('Select your date of birth') : Text("${birthDateInString}"),
                 ),
               ],
             ),
           )
         ),
       ),
     ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          height: 40,

          color: Color(0xFF304FFE),
          child: Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          onPressed: (){
            if(_formKey.currentState.validate()){
              validateForm(_firstName.text, _lastName.text, _email.text, );

            }
            },
        ),


      ],
    );
  }

  String validateForm(String first, String last, String email,  ) {
    setState(() {
      first = _firstName.text;
      last = _lastName.text;
      email = _email.text;

    });
    if (first.isEmpty) {
      showInSnackBar('Enter first name');
    } else if(last.isEmpty){
      showInSnackBar('Enter last name');
    }else if(email.isEmpty){
      showInSnackBar('Enter email');
    }else{
      needMedicinesBy();

    }
    return null;
  }

 needMedicinesBy(){
    return showDialog(
        context: context,
      builder: (context){
      return AlertDialog(
        title: Text(
          'I need medicines ',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('By uploading prescription'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => PrescriptionPage(
                  userId: widget.userId,
                    storeId: widget.storeId,
                  storeName: widget.storeName,
                  storeLocation: widget.storeLocation,
                  zipCode: widget.zipCode,
                  storeEmail:widget.storeEmail,
                  fName: _firstName.text,
                  lName: _lastName.text,
                  email: _email.text,
                  birthDate: birthDateInString,
                ),
              ));

            },
          ),
          FlatButton(
            child: Text('By selecting medicines'),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MedicationPage(
                  fName: _firstName.text,
                  lName: _lastName.text,
                  eMail: _email.text,
                  dBirth: birthDateInString,
                ),
              ));

            },
          ),
        ],
      );
      }
    );

}
}
