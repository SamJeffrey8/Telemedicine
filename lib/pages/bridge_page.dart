
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharmacy_app1/pages/home_page.dart';
import 'package:pharmacy_app1/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';


class BridgePage extends StatefulWidget {
  @override
  _BridgePageState createState() => _BridgePageState();
}

class _BridgePageState extends State<BridgePage> {



  String userName;
  String phone;
  int userId;
  String email;
  String lastName;



  @override
  void initState() {
    super.initState();
    _loggedInUser();

  }

  void  _loggedInUser() async {
    SharedPreferences _localStorage = await SharedPreferences.getInstance();
    var userJson = _localStorage.getString('User_info');
    var  user = jsonDecode(userJson);

    if (userJson != null) {
      setState(() {

        userName = user['first_name'];
        lastName = user ['first_name'];
        phone = user ['phone'];
        userId = user ['id'];
        email = user ['email'];

      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: userId != null ? HomePage(
          userId: userId,
          userName: userName,
         phone: phone,
          email: email,
          lastName: lastName,
        ): LoginPage());
  }
}
