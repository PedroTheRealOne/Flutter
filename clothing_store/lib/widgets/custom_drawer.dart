import 'package:flutter/material.dart';
import 'package:clothing_store/tiles/drawer_tile.dart';

Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ 
            Color.fromARGB(255, 203, 236, 241),
            Colors.white
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        ),
      ),
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
                      child: Text("Cloting\nStore",
                      style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold)
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hello, ",
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold
                           ),
                          ),
                          GestureDetector(
                            child: Text("Sing in or Sing up >",
                             style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                            onTap: (){

                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Home"),
              DrawerTile(Icons.list, "Products"),
              DrawerTile(Icons.location_on, "Find a store"),
              DrawerTile(Icons.playlist_add_check, "Orders"),
            ],
          ),
        ],
      ),
    );
  }
}