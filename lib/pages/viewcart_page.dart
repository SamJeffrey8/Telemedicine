import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_app1/pages/delivery_page.dart';
import 'package:pharmacy_app1/pages/medication_page.dart';

class ViewCartPage extends StatefulWidget {
  @override
  _ViewCartPageState createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {

  double _deviceHeight;
  double _deviceWidth;




  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
      //  automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF304FFE),
        elevation: 0.0,
        title: Text('View Cart'),
      ),


      body: Container(
        child: Column(
          children: <Widget>[
            _viewMedicines(),
            _checkOutPage(),
          ],
        ),
      )
    );
  }

  Widget _viewMedicines(){
    return  Expanded(
      child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index){
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 15, left: 15, bottom: 5),
                     // height: _deviceHeight * 0.2,
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
                                    image: AssetImage('images/medicine.jpg')
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding:  EdgeInsets.only(top:10.0, left: 10, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Rx number : 123456',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Medicine type : Pills or tabs'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Medicine name : Paracetamol'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Dosage : 650 mg'),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Qty : 10 tabs'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
          ),
    );
  }

  Widget _checkOutPage(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
         width: double.infinity,
          child: RaisedButton(
            color: Color(0xFF304FFE),
            child: Text(
              'Proceed',
             style: TextStyle(
               fontSize: 20,
               color: Colors.white
             ),
            ),
            onPressed: () {
             Navigator.push(context, MaterialPageRoute(
               builder: (context) => DeliveryPage(),
             ),);

            },
          ),
        );


  }
}
