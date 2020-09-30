
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_app1/Apis/pharmacy_apis.dart';
import 'package:pharmacy_app1/models/pharmacy_store.dart';
import 'package:pharmacy_app1/pages/stroes_pages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchLocationPage extends StatefulWidget {
  final  int userId;
  SearchLocationPage({
    this.userId,
  });
  @override
  _SearchLocationPageState createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {

  double _deviceHeight;
  double _deviceWidth;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _locationName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Pharmacy> pharmacyList =[];
  bool status;
  bool _onPressed = true;


  
  Future storeList() async{
    var api = PharmacyAppApis.storeListApi+_locationName.text;
    var _response = await http.get(api);
   if(_response.statusCode == 200){
     var results= json.decode(_response.body);

     setState(() {
       List dataList = results['Pharmacy'];
       if(dataList != null){
         pharmacyList = dataList.map((items) => Pharmacy.fromJson(items)).toList();

         print(pharmacyList);

       }
     });


   }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    storeList();
  }
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: _pinCodeUI(),

    );
  }
  Widget _pinCodeUI(){
    return Stack(
      children: <Widget>[
        _backgroundImage(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _searchBox(),
            SizedBox(
              height: 10,
            ),
            _enterButton()
          ],
        ),
      ],
    );

  }

  Widget _backgroundImage(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/pharmacy.png'),
          fit: BoxFit.cover,
          colorFilter:ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
        )
      ),
    );
  }

  Widget _searchBox(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      //height: _deviceHeight * 0.2,
      width: _deviceWidth,
      child: Form(
        key: _formKey,
         child: Card(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(30)
           ),
           child: TextFormField(
               cursorColor: Colors.green,
                    style: TextStyle(height: 1.8),
                    controller: _locationName,
                    decoration: InputDecoration(
                      hintText: 'Enter location or Zipcode',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Color(0xFF304FFE),
                      ),
                    ),
                  ),
         ),
      ),
    );
  }


  Widget _enterButton(){
    return Container(
      child: MaterialButton(
        height: 40,
        color: Color(0xFF304FFE),
        child: Text(
          'Enter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: ()async {
          if(_formKey.currentState.validate()){

            validateLocation(_locationName.text);
            setState(() {
              // _locationName.clear();
              pharmacyList.clear();
            });


          }
          },
      ),
    );
  }

   validateLocation(String value) async{
    if (value.isEmpty) {
      showInSnackBar('Please enter your location or zipcode');
    } else {
      await storeList();
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => StoreList(
          userId: widget.userId,
          pharmacyStoreList: pharmacyList,
        ),
      ));



    }
    return null;
  }

}
