import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_app1/pages/addreminder_page.dart';


class ReminderPage extends StatefulWidget {
  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {

  double _deviceHeight;
  double _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFF304FFE),
        title: Text('Reminders'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: _reminderPageUI(),
      ),
    );
  }

  Widget _reminderPageUI(){
    return Container(
      height: _deviceHeight* 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.access_time,
              size: 100,
            ),
            Text('No Reminders',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Its look like you do not have any medication reminders'),
            SizedBox(
              height: 30,
            ),
            _reminderButton(),
          ],
        ),
      ),
    );
  }

  Widget _reminderButton() {
    return  Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: _deviceHeight * 0.06,
           // width: _deviceWidth,
            child: MaterialButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    MdiIcons.batteryCharging,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'ADD DOSE REMINDER',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              color: Color(0xFF304FFE),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddReminderPage(),
                ));
              }
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: _deviceHeight * 0.06,
            // width: _deviceWidth,
            child: MaterialButton(
                child: Row(
                  children: <Widget>[
                    Icon(
                      MdiIcons.pill,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'ADD REFILL REMINDER',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                color: Color(0xFF304FFE),
                onPressed: () {

                }
            ),
          ),
        ),
      ],
    );
  }
}
