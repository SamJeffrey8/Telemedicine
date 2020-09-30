
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_app1/pages/review_page.dart';


class DeliveryPage extends StatefulWidget {
  final int userId, storeId;
  final String storeName, storeLocation, zipCode, storeEmail, fName, lName, email, birthDate;
  final image;
  DeliveryPage({
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
  });


  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _flatNo = TextEditingController();
  var _landMark = TextEditingController();
  var _alternatePhone = TextEditingController();
  var _comments = TextEditingController();

  String deliveryType;

  double _deviceHeight;
  double _deviceWidth;

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
        elevation: 0.0,
        backgroundColor: Color(0xFF304FFE),
        title: Text('Delivery'),
      ),
      body:SingleChildScrollView(
        child: _delivery(),
      )
    );
  }


  Widget _delivery(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: <Widget>[
          Container(

            height: _deviceWidth * 1.1,
            child: Form(
              key: _formKey,

              onChanged: (){
                _formKey.currentState.save();
              },
              child: Card(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text('Delivery',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF304FFE),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),

                    Text(
                      'Required following details for delivery \n'
                          'of your medicines',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        //fontWeight: FontWeight.bold
                      ),
                    ),

                    ListTile(
                      leading: const Icon(
                      MdiIcons.homeCity,
                        size: 30,
                        color: Color(0xFF304FFE),
                      ),
                      title: new TextFormField(
                        controller: _flatNo,
                        decoration: new InputDecoration(
                          hintText: "Flat no or Apartment name",
                        ),
                      ),
                    ),

                    new ListTile(
                      leading:  Icon(
                        MdiIcons.mapMarker,
                        size: 30,
                        color: Color(0xFF304FFE),
                      ),
                      title: new TextFormField(
                        controller: _landMark,
                        decoration: new InputDecoration(
                          hintText: "Land mark",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading:  Icon(
                        MdiIcons.phone,
                        size: 30,
                        color: Color(0xFF304FFE),

                      ),
                      title: new TextFormField(
                        controller: _alternatePhone,
                        decoration: new InputDecoration(
                          hintText: "Alternate phone no",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading:  Icon(
                        MdiIcons.message,
                        size: 30,
                        color: Color(0xFF304FFE),

                      ),
                      title: new TextFormField(
                        controller: _comments,
                        decoration: new InputDecoration(
                          hintText: "Any comments (optional)",
                        ),
                      ),
                    ),

                    ListTile(
                      leading: const Icon(
                        MdiIcons.truckDelivery,
                        size: 30,
                        color: Color(0xFF304FFE),
                      ),
                      title: new DropdownButtonFormField(
                        items: ["Delivery", 'PickUp'].map((item) {
                          return new DropdownMenuItem<String>(
                            value: item,
                            child: new Text(item),
                          );
                        }).toList(),
                        onChanged: (_input){
                          setState(() {
                            deliveryType = _input;
                          });
                        },
                        value: deliveryType,

                        decoration: new InputDecoration(
                          hintText: "Select Delivery type",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment:  MainAxisAlignment.center ,
            children: <Widget>[
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
                    validateForm(
                      _flatNo.text,
                      _landMark.text,
                      _alternatePhone.text,
                      deliveryType,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }


  String validateForm(String value1, String value2, String value3, String value5,){
    setState(() {
      value1 = _flatNo.text;
      value2 = _landMark.text;
      value3 = _alternatePhone.text;
      value5 = deliveryType;

    });

    if(value1.isEmpty){
      showInSnackBar('Enter flat or apartment name');

    }else if(value2.isEmpty){
      showInSnackBar('Enter your landmark');

    }else if (value3.isEmpty){
      showInSnackBar('Enter your alternate phone number');

    } else if(value5 == null){
      showInSnackBar('Select Delivery type');

    }else{

      Navigator.push(context, MaterialPageRoute(
        builder: (context) => ReviewPage(
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
          image: widget.image,
          flatOrAprt: _flatNo.text,
          landMark:   _landMark.text,
          alterPhone: _alternatePhone.text,
          comment:_comments.text,
          deliveryType:deliveryType,

        ),
      ));

    }
    return null;

  }
}
