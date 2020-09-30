import 'package:flutter/material.dart';
import 'package:pharmacy_app1/pages/profilefields_page.dart';


class OtpPage extends StatefulWidget {
  final String phoneNumber;
  OtpPage({
    this.phoneNumber,
});
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  double _deviceHeight;
  double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: _deviceWidth * 0.03),
          child: Align(
            alignment: Alignment.center,
            child: _otpUI(),
          ),
        ),
      ),
    );
  }

  Widget _otpUI(){
    return Container (
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.02),
      height: _deviceHeight * 0.4,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _headingText(),
          _inputForm(),
          SizedBox(
            height: 20,
          ),
          _registrationButton(),
        ],
      ),

    );
  }

  Widget _headingText(){
    return Container(
      height: _deviceHeight * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('Enter your email ',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Please enter it below',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }


  Widget _inputForm(){
    return Form(
      key: _formKey,
      onChanged: (){
        _formKey.currentState.save();
      },
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: email,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input){
              Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(pattern);
              if (_input.isEmpty){
                return "Enter email";
              }else if(!(regex.hasMatch(_input))){
                return 'Please enter valid email';
              }else{
                return null;
              }
              },

            decoration: InputDecoration(
              hintText: 'Email',
              labelText: 'Email',

            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.00,
          ),

        ],
      ),
    );
  }

  Widget _registrationButton(){
    return Container(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      color: Color(0xFF304FFE),
      child: MaterialButton(
        child: Text(
          'Enter',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),

        ),
        onPressed: (){
          if(_formKey.currentState.validate()){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProfileDetailsPage(
                phone: widget.phoneNumber,
                email: email.text,
              ),
            ));

          }

        },
      ),
    );
  }
}
