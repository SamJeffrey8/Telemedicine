import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_app1/pages/locationsearch_page.dart';
import 'package:pharmacy_app1/pages/login_page.dart';
import 'package:pharmacy_app1/pages/reminder_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  String  phone, userName, lastName, email;
  int userId;
  HomePage({
   this.userId,
   this.phone,
   this.userName,
    this.lastName,
   this.email,
});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: new Text(value, style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,

          backgroundColor: Color(0xFF304FFE),
          title: Text('Software Pharmacy'),
        ),
       drawer: Drawer(

         child: ListView(
           children: <Widget>[
             UserAccountsDrawerHeader(
               decoration: BoxDecoration(
                 color: Color(0xFF304FFE),
               ),
               accountName: Text("Abhishek"),
               accountEmail: Text("Abhishek@sofwaremechanics.com"),
               currentAccountPicture: CircleAvatar(
                 backgroundColor:Colors.white,
                 child: Text(
                   "A",
                   style: TextStyle(
                     fontSize: 40.0,
                     color: Color(0xFF304FFE),
                   ),
                 ),
               ),
             ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 children: <Widget>[
                   Row(
                     children: <Widget>[
                       Icon(
                         Icons.home
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Text('My Pharmacy',
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Row(
                     children: <Widget>[
                       Icon(
                           Icons.replay
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Text('Refills',
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Row(
                     children: <Widget>[
                       Icon(
                           Icons.access_time
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Text('Reminders',
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Row(
                     children: <Widget>[
                       Icon(
                           Icons.person
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Text('Profile',
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Row(
                     children: <Widget>[
                       Icon(
                           Icons.note_add
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       Text('Order history',
                         style: TextStyle(
                           fontSize: 15,
                         ),
                       ),
                     ],
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Row(
                     children: <Widget>[
                       Icon(
                           Icons.highlight_off
                       ),
                       SizedBox(
                         width: 10,
                       ),
                       GestureDetector(
                         onTap: (){
                           logoutUser();
                         },
                         child: Text('Logout',
                           style: TextStyle(
                             fontSize: 15,
                           ),
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
           ],
         ),
       ),
        body: Padding(
          padding:  EdgeInsets.only(top:30),
          child: Column(
            children: <Widget>[
              _headingText(),
              SizedBox(
                height: 20,
              ),
              _refills(),
              _reminders(),
              _location()
            ],
          ),
        ),
      ),
    );
  }

  Widget _headingText(){
    return Column(
      children: <Widget>[
        Text('Welcome to Pharmacy',
          style: TextStyle(
            fontSize: 20
          ),
        )
      ],
    );
  }

  Widget _refills (){
    return Column(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SearchLocationPage(
                  userId: widget.userId,
                ),
              ));
            },
            child: Container(
              height: 120,
              width: double.infinity,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 100,
                      child: Icon(
                        Icons.replay,
                        size: 60,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Refills', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text('Enter your refills manually, by using \n'
                                'a profile or by scanning your prescriptions barcode '),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _reminders(){
    return Column(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: (){
             Navigator.push(context, MaterialPageRoute(
               builder: (context) => ReminderPage(),
             ));

            },
            child: Container(
              height: 120,
              width: double.infinity,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 100,
                      child: Icon(
                        Icons.alarm_on,
                        size: 60,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Reminders', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text('Help remember when its time to take\n'
                                'your medications '),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ),
          ),
        ),
      ],
    );

  }
  Widget _location(){
    return Column(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: (){
              showInSnackBar('Its Under Development');
            },
            child: Container(
              height: 120,
              width: double.infinity,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 110,
                      width: 100,
                      child: Icon(
                        Icons.location_on,
                        size: 60,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Locations', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text('Look up location hours, address\n'
                                'and contact information  '),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );

  }


  void logoutUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('User_info');
   Navigator.push(context, MaterialPageRoute(
     builder: (context)=> LoginPage(),
   ));
  }

}
