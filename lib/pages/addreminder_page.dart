import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class AddReminderPage extends StatefulWidget {
  @override
  _AddReminderPageState createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var medicineName = TextEditingController();
  double _deviceHeight;
  double _deviceWidth;
  TimeOfDay _currentTime = new TimeOfDay.now();
  TimeOfDay time;

  bool _Sselected = false;
  bool _Mselected = false;
  bool _Tselected = false;
  bool _Wselected = false;
  bool _Thselected = false;
  bool _Fselected = false;
  bool _Saselected = false;

  bool _isSelected = false;



  void initState() {
    super.initState();

    time = TimeOfDay.now();
  }

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
    _deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    _deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF304FFE),
          title: Text('Dose Reminder'),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            dosePageUI(),

            selectTime(),
            SizedBox(
              height: 20,
            ),
            weeksBubble(),
          ],
        )
    );
  }

  Widget dosePageUI() {
    return ListTile(
      leading: Icon(
          MdiIcons.pill,
          size: 30,
          color: Color(0xFF304FFE)

      ),
      title: Form(
        key: _formKey,
        onChanged: (){
          _formKey.currentState.save();
        },
        child: TextField(
          controller: medicineName,
          decoration: InputDecoration(
            hintText: "Enter Medicine name",
          ),
        ),
      ),
    );
  }

  Widget weeksBubble() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: _Sselected ? () {
                  setState(() {
                    _Sselected = false;
                  });
                } : () {
                  setState(() {
                    _Sselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Sselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'S',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _Mselected ? () {
                  setState(() {
                    _Mselected = false;
                  });
                } : () {
                  setState(() {
                    _Mselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Mselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'M',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _Tselected ? () {
                  setState(() {
                    _Tselected = false;
                  });
                } : () {
                  setState(() {
                    _Tselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Tselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'T',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _Wselected ? () {
                  setState(() {
                    _Wselected = false;
                  });
                } : () {
                  setState(() {
                    _Wselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Wselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'W',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _Thselected ? () {
                  setState(() {
                    _Thselected = false;
                  });
                } : () {
                  setState(() {
                    _Thselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Thselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'T',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _Fselected ? () {
                  setState(() {
                    _Fselected = false;
                  });
                } : () {
                  setState(() {
                    _Fselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Fselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'F',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: _Saselected ? () {
                  setState(() {
                    _Saselected = false;
                  });
                } : () {
                  setState(() {
                    _Saselected = true;
                  });
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: _Saselected ? Colors.black : Color(
                      0xFF304FFE),
                  child: Text(
                    'S',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        _addButton(),
      ],
    );
  }

  Widget selectTime() {
    return Container(
      child: ListTile(
        leading: Icon(
          Icons.access_time,
          size: 35, color: Color(0xFF304FFE),
        ),
        title: ListTile(
          title: !_isSelected ? Text("Select medicine timing") : Text(
              "Time ${time.hour}:${time.minute}"),
          trailing: Icon(Icons.keyboard_arrow_down),
          onTap: _pickTime,
        ),
      ),
    );
  }

  _pickTime() async {
    TimeOfDay t = await showTimePicker(
        context: context,
        initialTime: time
    );
    if (t != null)
      setState(() {
        time = t;
        _isSelected = true;
      });
  }

  Widget _addButton() {
    return MaterialButton(
      height: 40,
      color: Color(0xFF304FFE),
      child: Text(
        'ADD',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        if(_formKey.currentState.validate()){
          validateForm(
              medicineName.text,
              _Sselected,
              _Mselected,
              _Tselected,
              _Wselected,
              _Thselected,
              _Fselected,
              _Saselected,
              _isSelected,
          );

        }

      },
    );
  }

  String validateForm(String medicine,
      bool value1, value2, value3, value4, value5,value6, value7, value8) {
    setState(() {
      medicine = medicineName.text;
      value1 = _Sselected;
      value2 = _Mselected;
      value3 = _Tselected;
      value4 = _Wselected;
      value5 = _Thselected;
      value6 = _Fselected;
      value7 = _Saselected;
      value8 = _isSelected;
    });

    if(medicine.isEmpty){
      showInSnackBar('Please enter medicine name');


    }else if (value8== false){
      showInSnackBar('please select dose time');
    }else if(
    value1 == false && value2 == false
    && value3 == false && value4 == false
    && value5 == false && value6 == false
    && value7 == false
    )
      showInSnackBar('Please select at least oneday of the week');

  }
}
