import 'package:flutter/material.dart';
import 'package:pharmacy_app1/Apis/pharmacy_apis.dart';
import 'package:pharmacy_app1/pages/orderplace_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class ReviewPage extends StatefulWidget {
  final int userId, storeId;
  final String storeName, storeLocation, zipCode, storeEmail, fName, lName, email, birthDate;
  final String  flatOrAprt, landMark, alterPhone, comment, deliveryType;
  final image;
  ReviewPage({
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
    this.image,
    this.flatOrAprt,
    this.landMark,
    this.alterPhone,
    this.comment,
    this.deliveryType,
  });
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  bool orderStatus;

  Future orderProcessing() async{
    var api ='https://pharmacy13.herokuapp.com/api/customer/';
    String base64Image = base64Encode(widget.image.readAsBytesSync());
    String fileName = widget.image.path.split("/").last;
    var data = {
      "first_name" : widget.fName,
      "last_name" : widget.lName,
      "email" : widget.email,
      "dob" : widget.birthDate,
      "rx_number" : "drug2",
      "med_type" : "ss",
      "drug" : "sgwg",
      "dosage" : "5",
      "quantity" : "22",
      "image" :fileName,
      "flat": widget.flatOrAprt,
      "land_mark" : widget.landMark,
      "alter_phone" : widget.alterPhone,
      "comments" : widget.comment,
      "delivery_type" : widget.deliveryType,
      "pharmacy_id" : 11.toString(),
    };
    try{
      var response = await http.post(api,body: data, headers: {
        "Authorization" : "Token 21b007b567025e91a7bf9809d8a02592041604a4",
      });
      if(response.statusCode == 200){
        var results = json.decode(response.body);
        setState(() {
       print(results);
        });



      }else{
        print('meer');
      }

    }catch(e){
      print(e);
    }


  }


  @override
  Widget build(BuildContext context) {

    // print(widget.userId);
    // print(widget.storeId);
    // print(widget.storeName);
    // print(widget.storeLocation);
    // print(widget.storeEmail);
    // print(widget.fName);
    // print(widget.lName);
    // print(widget.email);
    // print(widget.birthDate);
    // print(widget.flatOrAprt);
    // print(widget.landMark);
    // print(widget.alterPhone);
    // print(widget.comment);
    // print(widget.deliveryType);
    // print(widget.image);




    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF304FFE),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text('Review'),
      ),
      body: _reviewData(),
    );
  }

  Widget _reviewData(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: <Widget>[
        Text(
            'Please Review your entered fields',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
          SizedBox(
            height: 30,
          ),
          Card(
            child: Container(
              margin: EdgeInsets.all(10),
              //height: 400,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('First name :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                        fontSize: 17,
                        ),
                      ),
                      Text(widget.fName,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        )
                        ),
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF304FFE),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Last name :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(widget.lName,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF304FFE),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Email :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(widget.email,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF304FFE),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Date of Birth :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text(widget.birthDate,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF304FFE),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                 widget.image != null ? Container(
                   child: Text(
                       'Prescription uploaded',
                     style: TextStyle(
                         fontSize: 17,
                         fontWeight: FontWeight.bold
                     ),

                   ),

                 ) :Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Medicines :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text('Example-1',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('Example-2',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('Example-3',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('Example-4',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text('Example-5',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Delivery :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(widget.flatOrAprt,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(widget.landMark,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(widget.alterPhone,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(widget.deliveryType,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Comments :',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Text(widget.comment,
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          nextButton()

        ],
      ),
    );
  }

  Widget nextButton(){
    return  MaterialButton(
      height: 40,
      child: Text('Next',
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      color: Color(0xFF304FFE),
      onPressed: () async{
     await   orderProcessing();
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (context)=> OrderPlacePage()
        // ));


      },
    );
  }
}
