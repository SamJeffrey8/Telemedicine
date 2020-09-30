import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_app1/pages/delivery_page.dart';
import 'package:pharmacy_app1/pages/review_page.dart';


class PrescriptionPage extends StatefulWidget {
  final int userId, storeId;
  final String storeName, storeLocation, zipCode, storeEmail, fName, lName, email, birthDate;
  PrescriptionPage({
   this.userId,
   this.storeId,
   this.storeName,
   this.storeLocation,
   this.zipCode,
   this.storeEmail,
   this.fName,
   this.lName,
   this.email,
   this.birthDate,
});

  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {



  double _deviceHeight;
  double _deviceWidth;


  File _image;


  @override
  Widget build(BuildContext context) {

    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text('Upload prescription'),
      ),
      body: _prescriptionFile(),

    );
  }

  Widget _prescriptionFile(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text('Please ensure that prescription \n'
              'should be image format',
          textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Card(
            child: GestureDetector(
              onTap: () async{
                File _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _image = _imageFile;
                });
              },
              child: Container(
                margin: EdgeInsets.all(9),
                height: _deviceHeight * 0.5,
                width: _deviceWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _image != null ? FileImage(_image): AssetImage('images/u1.png'),
                    fit: BoxFit.cover
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _image != null ? MaterialButton(
            height: 40,
            child: Text('Next',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
            ),
            color: Colors.green,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DeliveryPage(
                  userId: widget.userId,
                  storeId: widget.storeId,
                  storeName: widget.storeName,
                  storeLocation: widget.storeLocation,
                  zipCode: widget.zipCode,
                  storeEmail:widget.storeEmail,
                  fName: widget.fName,
                  lName: widget.lName,
                  email: widget.email,
                  birthDate: widget.birthDate,
                  image: _image,
                ),
              ));
              },
          ) : Container(),
        ],
      ),
    );
  }
}
