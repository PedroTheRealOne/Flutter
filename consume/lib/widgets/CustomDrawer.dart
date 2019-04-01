import 'package:flutter/material.dart';
import 'package:quantumlabs_flutter_widgets/quantumlabs_flutter_widgets.dart';
import 'package:consume/api/Auth.dart';
import 'package:consume/views/LoginView.dart';

Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    );

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text(
                        "Generic \nTweeter",
                        style: TextStyle(
                            fontSize: 34.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(padding: CustomEdgeInsets().symmetric16lp()),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: GestureDetector(
                        child: Text("Logout",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                        onTap: () async {
                          await Auth().logout();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()),
                              (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
