import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pharmacy_app1/Apis/pharmacy_apis.dart';
import 'package:pharmacy_app1/pages/home_page.dart';
import 'package:pharmacy_app1/pages/registration_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  double _deviceHeight;
  double _deviceWidth;
  final _formKey = GlobalKey<FormState>();
  String phone;
  String password;
  int userId;
  String userEmail;
  String userName;
  String userPhone;
  String userLastName;
  bool _onPressed = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    var authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    FirebaseUser currentUser = (await _auth.signInWithCredential(credential)).user;
    assert(user.uid == currentUser.uid);
    setState(() {
      String userUID = userId.toString();
      userUID = currentUser.uid;
    });
    return 'signInWithGoogle succeeded: $user';
  }

  Future _loginApi() async{
    var api = PharmacyAppApis.loginApi;
    var data ={
      "email" : phone,
      'password' : password,
    };
    var _response = await http.post(api, body: data);
    if (_response.statusCode==200){

      var _results = json.decode(_response.body);

      setState(() {
        userId = _results['user']['id'];
        userName = _results['user']['username'];
        userEmail = _results["user"] ['email'];
        userPhone = _results ['user']['phone'];
        userLastName = _results ['user']['last_name'];

      });
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(
          userId: userId,
          userName: userName,
          phone: userPhone,
          email: userEmail,
          lastName: userLastName,

        )
      ));
    }else {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return   AlertDialog(
            title: Text('Invalid user'),
            content: Text('Your not a valid user, please signUp with us '
            ),
            actions: [
              FlatButton(
                child: Text(
                    'Ok'
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    _onPressed = true;
                  });
                },
              )
            ],
          );
        },
      );

    }
  }


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: ()=> SystemNavigator.pop(),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: Align(
              alignment: Alignment.center,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _loginUI(),
                ],
              )
          ),
        ),
      ),
    );
  }

  Widget _loginUI() {
    return Builder(
      builder: (BuildContext _context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          height: _deviceHeight * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headingText(),
              _inputForm(),
              SizedBox(
                height: 7,
              ),
              _loginButton(),

              _registerButton(),
              //_googleSignIn()
            ],
          ),
        );
      },
    );
  }

  Widget _headingText() {
    return Container(
      height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome back!',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Please login to your account',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Form(
      key: _formKey,
      onChanged: () {
        _formKey.currentState.save();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input) {
              return _input.length != 0
                  ? null
                  : "Please enter email";
            },
            onSaved: (_input) {
              setState(() {
                phone = _input;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter email',
              labelText: 'Email',
            ),
          ),
          SizedBox(
            height: _deviceHeight * 0.02,
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
            ),
            validator: (_input) {
              return _input.length != 0 ? null : 'Please enter password';
            },
            onSaved: (_input) {
              setState(() {
                password = _input;
              });
            },
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',

            ),
          ),
        ],
      ),
    );
  }
  Widget _loginButton() {
    return  _onPressed ? Container(
      height: _deviceHeight * 0.06,
      width: _deviceWidth,
      child: MaterialButton(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        color: Color(0xFF304FFE),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {
              _onPressed = false;
            });
            _loginApi();

          }
        },
      ),
    ) : SpinKitCircle(
      color: Colors.blue,
    );
  }
  Widget _registerButton() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              'Dont have an account.?',
              style: TextStyle(
                  fontSize: 15
              ),
            ),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => RegistrationPage()
                ));

              },
              child: Text(
                  'SignUp',
                style: TextStyle(
                  color: Color(0xFF304FFE),
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
       SizedBox(
      height: 20,
       ),
        _gsignInButton(),
      ],
    );
  }
  Widget _gsignInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _loginApi();
        signInWithGoogle().whenComplete((){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => RegistrationPage(),
          ));
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Color(0xFF304FFE),),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF304FFE),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
