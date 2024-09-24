import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userInitial = 'U';
  String userName = 'User';
  bool pushNotificationsEnabled = false;
  bool darkModeEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      userInitial,
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSectionTitle('Account Settings'),
            _buildAccountOption(context, 'Edit Profile', () {
              // Navigate to Edit Profile Screen
            }),
            _buildAccountOption(context, 'Change Password', () {
              // Navigate to Change Password Screen
            }),
            _buildAccountOption(context, 'Add Payment Method', () {
              // Navigate to Add Payment Method Screen
            }),
            _buildAccountOption(context, 'Log out', () {
              // Handle logout
            }),
            SizedBox(height: 20),
            _buildSectionTitle('App Settings'),
            _buildAppSettingOption(context, 'Push Notifications', (value) {
              setState(() {
                pushNotificationsEnabled = value;
              });
            }, pushNotificationsEnabled),
            _buildAppSettingOption(context, 'Dark Mode', (value) {
              setState(() {
                darkModeEnabled = value;
              });
            }, darkModeEnabled),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAccountOption(BuildContext context, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300] ?? Colors.grey),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSettingOption(BuildContext context, String title, ValueChanged<bool> onChanged, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

