import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pharmacy_app1/Apis/pharmacy_apis.dart';
import 'package:pharmacy_app1/models/druglist.dart';
import 'package:pharmacy_app1/pages/review_page.dart';
import 'package:pharmacy_app1/pages/viewcart_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MedicationPage extends StatefulWidget {

  final String fName, lName, eMail, dBirth;
  MedicationPage({
    this.fName,
    this.lName,
    this.eMail,
    this.dBirth,
});
  @override
  _MedicationPageState createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var  _rxNumber = TextEditingController();
  var _typeOfDrug = TextEditingController();
  var _drugName = TextEditingController();
  var _dose = TextEditingController();
  var _qty = TextEditingController();
  var medicineType ;
  List<Pharmacy> pharmacyList = [];
  String _selectedDrug;
  int _selectedId;


  bool _onPressed = true;
  bool _cart = false;
  int cartItems = 0;

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
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF304FFE),
        elevation: 0.0,
        title: Text('Medication'),
      ),
      body: SingleChildScrollView(
        child: _medication(),
      )

    );
  }

  Widget _medication(){
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
                    Text('Medications',
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
                      'Enter your Rx numbers for this order.\n'
                        'While not required, it is recommended you \n'
                        'enter medication name as well',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          //fontWeight: FontWeight.bold
                      ),
                    ),

                    ListTile(
                      leading: const Icon(Icons.local_pharmacy,
                      size: 30,
                        color: Color(0xFF304FFE),
                      ),
                      title: new TextFormField(
                         controller: _rxNumber,
                        decoration: new InputDecoration(
                          hintText: "Enter Rx number (Ex: 123456)",
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                         MdiIcons.briefcasePlus,
                        size: 30,
                        color: Color(0xFF304FFE),
                      ),
                      title: new DropdownButtonFormField(
                        items: ["Pills or Tabs", "Capsules", 'Syrups', "Ointments"].map((item) {
                          return new DropdownMenuItem<String>(
                            value: item,
                            child: new Text(item),
                          );
                        }).toList(),
                        onChanged: (_input){
                          setState(() {
                            medicineType = _input;
                          });
                        },
                        value: medicineType,

                        decoration: new InputDecoration(
                          hintText: "Select medicine type",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading:  Icon(
                        MdiIcons.pill,
                        size: 30,
                        color: Color(0xFF304FFE),

                      ),
                      title: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(

                          controller: _drugName,
                          decoration: InputDecoration(
                            hintText: 'Drug or Brand (Ex: Paracetamol)',
                          ),
                        ),
                          suggestionsCallback: (pattern) async {

                            var api ='https://pharmacy13.herokuapp.com/api/drug/?q=${_drugName.text}';
                           // // var api = PharmacyAppApis.drugsApi +
                           //      "${_drugName.text}";

                            try {
                              var response = await http.get(api, headers: {
                                'Authorization' : "Token 21b007b567025e91a7bf9809d8a02592041604a4"
                              });
                              if (response.statusCode == 200) {
                                var _results = json.decode(response.body);
                                DrugsList drugsList = DrugsList.fromJson(_results);
                                print(drugsList);

                                List<String> drugs = [];

                                Completer<List<String>> completer = Completer();
                                for (int i = 0; i <
                                    drugsList.pharmacy.length; i++) {
                                  drugs.add(
                                      drugsList.pharmacy[i].drug);
                                }
                                pharmacyList = drugsList.pharmacy;
                                completer.complete(drugs);
                                return completer.future;
                              } else {
                                print('Error');
                              }
                            } catch (e) {

                                List<String> moreThan = [
                                  'No results found '
                                ];
                                Completer<List<String>> completer = Completer();
                                completer.complete(moreThan);
                                return completer.future;

                            }
                            return null;
                          },

                          itemBuilder: (context, suggestion,) {
                            return ListTile(
                              title: Text(suggestion),

                            );
                          },

                          transitionBuilder: (context, suggestionsBox,
                              controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion,) {
                            this._drugName.text = suggestion;

                          },
                          onSaved: (value) {
                            _selectedDrug = value;
                            pharmacyList.forEach((element) {
                              if (element.drug == _selectedDrug) {
                                setState(() {
                                  _selectedId = element.id;
                                });
                              }
                            });
                          }
                      ),
                    ),
                    new ListTile(
                      leading:  Icon(
                        MdiIcons.batteryCharging,
                        size: 30,
                        color: Color(0xFF304FFE),

                      ),
                      title: new TextFormField(
                        controller: _dose,
                        decoration: new InputDecoration(
                          hintText: "Dosage (Ex:650 mg)",
                        ),
                      ),
                    ),
                    new ListTile(
                      leading:  Icon(
                        MdiIcons.numeric,
                        size: 30,
                        color: Color(0xFF304FFE),

                      ),
                      title: new TextFormField(
                       controller: _qty,
                        decoration: new InputDecoration(
                          hintText: "Enter Qty  (Ex: 10 Tabs)",
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
            mainAxisAlignment: !_cart ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
           children: <Widget>[
             _onPressed ? MaterialButton(
               height: 40,
               color: Color(0xFF304FFE),
               child: Text(
                 'Add',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
               onPressed: (){
                 if(_formKey.currentState.validate()){
                   validateForm(
                     _rxNumber.text,
                     medicineType,
                     _drugName.text,
                     _dose.text,
                     _qty.text,
                   );
                 }
               },
             ):SpinKitCircle(color: Color(0xFF304FFE),),
             _cart ? MaterialButton(
               height: 40,
               color: Color(0xFF304FFE),
               child: Text(
                 'View Cart (${cartItems})',
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 20,
                 ),
               ),
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(
                   builder: (context) => ViewCartPage(),
                 ));

               },
             ) : Container(),


           ],
         ),
        ],
      ),
    );
  }

  String validateForm(String value1, String value2, String value3, String value4, String value5,){
    setState(() {
      value1 = _rxNumber.text;
      value2 = medicineType;
      value3 = _drugName.text;
      value4 = _dose.text;
      value5 = _qty.text;

    });

    if(value1.isEmpty){
      showInSnackBar('Enter Rx number');
      setState(() {
        _onPressed = true;

      });
    }else if(value2 == null){
      showInSnackBar('Select medicine type');
      setState(() {
        _onPressed = true;

      });
    }else if (value3.isEmpty){
      showInSnackBar('Enter Drung or Brand name');
      setState(() {
        _onPressed = true;

      });
    } else if (value4.isEmpty){
      showInSnackBar('Enter Dose of the Medicine');
      setState(() {
        _onPressed = true;

      });
    }else if(value5.isEmpty){
      showInSnackBar('Enter qty required');
      setState(() {
        _onPressed = true;

      });
    }else{
      setState(() {
        _onPressed = false;

      });
      Future.delayed(Duration(seconds: 2),(){
        showAlertDialogue();
      });

    }
    return null;

  }

  showAlertDialogue(){
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: ( context){
          return AlertDialog(
            content: Row(
              children: <Widget>[
                Expanded(child: Text('Do you want to add more medicines...? ')),
              ],
            ),
            title: Row(
              children: <Widget>[
                Icon(
                  MdiIcons.checkCircle,
                  size: 40,
                  color: Color(0xFF304FFE),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Text(
                        'Medicine successfully added into cart',
                      style: TextStyle(
                        fontSize: 18
                      ),
                    )
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    _onPressed = true;
                    _rxNumber.clear();
                    medicineType = null;
                    _drugName.clear();
                    _dose.clear();
                    _qty.clear();
                    _cart= true;
                    cartItems++;
                  });
                  },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ViewCartPage(),
                  ));
                  },
              ),
            ],
          );
        }

    );
  }

}

