import 'package:flutter/material.dart';
import 'package:clothing_store/tiles/drawer_tile.dart';
import 'package:clothing_store/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:clothing_store/models/user_model.dart';

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

  final PageController pageController;

  CustomDrawer(this.pageController);
  
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
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Hello, ${!model.isLoggedIn()? "" : model.userData["name"]}",
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold
                           ),
                          ),
                          GestureDetector(
                            child: Text(!model.isLoggedIn() ? "Sing in or Sing up >" : "Logout",
                             style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                              ),
                              ),
                            onTap: (){
                              if(!model.isLoggedIn()){
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => LoginScreen())
                              );
                              } else {
                                model.singOut();
                              }
                            },
                          )
                        ],
                      );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Home", pageController, 0),
              DrawerTile(Icons.list, "Products", pageController, 1),
              DrawerTile(Icons.location_on, "Find a store", pageController, 2),
              DrawerTile(Icons.playlist_add_check, "Orders", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}