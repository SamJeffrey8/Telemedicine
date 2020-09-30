import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_app1/pages/home_page.dart';

class OrderPlacePage extends StatefulWidget {
  @override
  _OrderPlacePageState createState() => _OrderPlacePageState();
}

class _OrderPlacePageState extends State<OrderPlacePage> {


  bool placed = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      _loadPage();
      setState(() {
        placed = false;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: placed ? Colors.white : Color(0xFF304FFE),
      body:Center(
        child: _loadPage(),
      )

    );
  }

  Widget _loadPage(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 220),
      child: Column(
        children: <Widget>[
          Container(
            child: placed ? SpinKitDoubleBounce(
              color: Color(0xFF304FFE),
              size: 50,
            ) : Icon(
              Icons.check_circle,
              size: 60,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          placed ? Text('Your order is processing.....',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF304FFE),
            ),
          )
              : Text('Your Order successfully placed',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          ),
          SizedBox(
            height: 20,
          ),
          !placed ? MaterialButton(
            height: 40,
            child: Text('OK'),
            color: Colors.white,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => HomePage()
              ));

            },
          ): Container(),
        ],
      ),
    );
  }
}
