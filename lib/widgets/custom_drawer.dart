import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final double screenHeight;
  const CustomDrawer(
      {super.key, required this.scaffoldKey, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const  BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: CircleAvatar(
                          radius: screenHeight * 0.05,
                          child: Icon(
                            Icons.person,
                            size: screenHeight * 0.05,
                          ))),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('John Doe'),
                  )
                ],
              )),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.home),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Home'),
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, 'homePage');
              scaffoldKey.currentState?.closeDrawer();
            },
          ),ListTile(
            title: Row(
              children: const [
                Icon(Icons.favorite),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Favorites'),
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, 'favoritesPage');
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
          ListTile(
            title: Row(
              children: const [
                Icon(Icons.download),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Downloads'),
                )
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, 'downloadsPage');
              scaffoldKey.currentState?.closeDrawer();
            },
          ),
        ],
      ),
    );
  }
}
