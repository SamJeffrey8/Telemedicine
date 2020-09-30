import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_app1/Apis/pharmacy_apis.dart';
import 'package:pharmacy_app1/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'dart:async';


class ProfileDetailsPage extends StatefulWidget {
  final String phone, email;
  ProfileDetailsPage({
   this.phone,
   this.email,
});
  @override
  _ProfileDetailsPageState createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _userName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  double _deviceHeight;
  double _deviceWidth;

  var userId;
  bool _onPressed = true;

  Future signUpApi() async{

    var api = PharmacyAppApis.signUpApi;
    var data ={
      "phone" : widget.phone,
      "email" : widget.email,
      //i assigned first name for username
      'username' : _userName.text,
      "last_name" : _lastName.text,
      "password" : _password.text,
    };
    var _response = await http.post(api, body: data);
    if(_response.statusCode == 201){
      var _results = json.decode(_response.body);
      SharedPreferences _localStorage = await SharedPreferences.getInstance();
     await _localStorage.setString('UserDetails', json.encode(_results['User_info']));
      var userJson = _localStorage.getString('UserDetails');
      var user = json.decode(userJson);

      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(
          userId: userId,
          phone: widget.phone,
          email: widget.email,
          userName: _userName.text,
          lastName: _lastName.text,
        ),
      ));

    }else{
      return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('User registration alert '),
            content: Text('Hello ${_userName.text}.. already registered with us please login' ),
            actions: [
              FlatButton(
                child: Text('Ok'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> LoginPage()
                  ));
                },
              )
            ],
          );
        }
      );



    }

  }

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
                padding:  EdgeInsets.symmetric(vertical: _deviceHeight * 0.09),
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
          Text('Enter your personal details ',
            style: TextStyle(
              fontSize: 25,
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
            controller: _userName,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),

            decoration: InputDecoration(
              hintText: 'Enter first name ',
              labelText: 'First name',
              prefixIcon: Icon(
                  Icons.person_pin,
                color: Color(0xFF304FFE),
              ),

            ),
            validator: (_input){
              return _input.length !=0 ? null :'Please first name';

            },
          ),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          TextFormField(
            controller: _lastName,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input){
              return _input.length !=0 ? null :'Please last name';
              },
            decoration: InputDecoration(
                hintText: 'Last name',
                labelText: 'Last name',
                prefixIcon: Icon(
                  Icons.person,
                  color: Color(0xFF304FFE),
                )
            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          TextFormField(
            controller: _password,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input){
              return _input.length !=0 && _input.length >=6 ? null : 'Password should be more 6 characters';

            },

            decoration: InputDecoration(
                hintText: 'Enter password',
                labelText: 'Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF304FFE),
                )
            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          TextFormField(
            controller: _confirmPassword,
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input){
              if(_input.isEmpty){
                return 'Please enter confirm password';
              }else if(_input != _password.text ){
                return 'Confirm password not match';
              }else{
                return null;
              }

            },

            decoration: InputDecoration(
                hintText: 'Confirm password',
                labelText: 'Confirm Password',
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xFF304FFE),
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _registrationButton(){
    return _onPressed ?  Container(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      color: Color(0xFF304FFE),
      child: MaterialButton(
        child:  Text(
          'Enter',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),

        ),

        onPressed: (){
          if(_formKey.currentState.validate()){

            setState(() {
              _onPressed = false;
            });
            signUpApi();

          }

        },
      ),
    ) :SpinKitCircle(
      color: Colors.blue,
    );
  }
}
