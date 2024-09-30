import 'package:flutter/material.dart';
import 'package:prj_localisation/profile_list/about.dart';
import 'package:prj_localisation/profile_list/help.dart';
import 'package:prj_localisation/profile_list/notification.dart';
import 'package:prj_localisation/profile_list/settings.dart';
class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // User Account Header
          UserAccountsDrawerHeader(
            accountName: Text(
              "Ashfak Sayem",
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "ashfaksayem@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('images/profile.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.purple[50],
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: <Widget>[
                _buildDrawerItem(0, Icons.notifications, 'Notifications', context, NotificationPage()),
                _buildDrawerItem(1, Icons.help, 'Help', context, HelpPage()),
                _buildDrawerItem(2, Icons.settings, 'Settings', context, SettingsPage()),
                _buildDrawerItem(3, Icons.info, 'About', context, AboutPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(int index, IconData icon, String title, BuildContext context, Widget page) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: Container(
        color: _hoveredIndex == index ? Colors.purple[50] : Colors.transparent, // Change background color on hover
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          onTap: () {
            // Handle tap and navigate to the corresponding page
            Navigator.of(context).pop(); // Close the drawer
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => page)); // Navigate to the selected page
          },
        ),
      ),
    );
  }
}