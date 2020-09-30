import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pharmacy_app1/models/pharmacy_store.dart';
import 'package:pharmacy_app1/pages/patientinfe_page.dart';


class StoreList extends StatefulWidget {
  final userId;
  List<Pharmacy> pharmacyStoreList =[];
  StoreList({
    this.userId,
    this.pharmacyStoreList,

});
  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {

  double _deviceHeight;
  double _deviceWidth;
  int storeUserId;
  String storeName;
  String location;
  String zipCode;
  String stroeEmail;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Color(0xFF304FFE),
        title: Text('Select a medical store'),
      ),
      body: _storeList(),
    );
  }

  Widget _storeList(){
    print(stroeEmail);

    return widget.pharmacyStoreList.isEmpty ? Container(
      child: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/sorry.jpg'),
                )
              ),
            ),
            Text('There is no stores found'),
          ],
        ),
      ),
    ):Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
          itemCount: widget.pharmacyStoreList.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
              onTap: (){
                setState(() {
                  storeUserId = widget.pharmacyStoreList[index].id;
                  storeName = widget.pharmacyStoreList[index].name;
                  location = widget.pharmacyStoreList[index].city;
                  zipCode = widget.pharmacyStoreList [index].zipcode;
                  stroeEmail = widget.pharmacyStoreList[index].email;
                });

                // print(stroeEmail);
                // print(zipCode);
                // print(location);
                // print(storeName);

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PatientInfoPage(
                    userId: widget.userId,
                    storeId: storeUserId,
                    storeName: storeName,
                    storeEmail: stroeEmail,
                    zipCode: zipCode,
                    storeLocation: location,
                  ),
                ));
              },
              child: Container(
                padding: EdgeInsets.only(right: 15, left: 15, bottom: 5),
                //height: _deviceHeight * 0.2,
                width: _deviceWidth,
                child: Card(
                  elevation: 5.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                       height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/store.png')
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding:  EdgeInsets.only(top:10.0, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(widget.pharmacyStoreList[index].name,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.pharmacyStoreList[index].city)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ),
            );
          }
      ),
    );
  }
}
