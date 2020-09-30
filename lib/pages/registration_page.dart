import 'package:flutter/material.dart';
import 'package:pharmacy_app1/pages/otp_page.dart';


class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController _phone = TextEditingController();
  final controller = TextEditingController(text: "Your initial value");

  double _deviceHeight;
  double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: _deviceHeight * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _registrationUI(),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }

  Widget _registrationUI(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
      height: _deviceHeight * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _headingText(),
          SizedBox(
            height: _deviceHeight * 0.04,
          ),
          _inputForm(),
          SizedBox(
            height: _deviceHeight * 0.04,
          ),
          _registrationButton(),

        ],
      ),
    );
  }

  Widget _headingText(){
    return Container(
      height: _deviceHeight * 0.10,
      width: _deviceWidth,
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text('Hello ',
            style: TextStyle(
              fontSize: 35,
            ),
          ),
          Text('SignUp to continue')
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

            controller: _phone,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input){
              return _input.length !=0 && _input.length == 13 ? null :'Please enter valid mobile number';

            },

            decoration: InputDecoration(
                hintText: 'Enter phone number',
                labelText: 'Phone',

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
           builder: (context) => OtpPage(
             phoneNumber:_phone.text ,
           ),
         ));

          }

        },
      ),
    );
  }
}
