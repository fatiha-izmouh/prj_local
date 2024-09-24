import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile_list/about.dart';
import '../profile_list/help.dart';
import '../profile_list/notification.dart';
import '../profile_list/settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200]!,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/profile.png'),
                ),
              ),
              const SizedBox(height: 16),
              // Profile name and email
              Text(
                'Coding with T',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'superAdmin@codingwitht.com',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              // Settings list
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildListTile(context, 'Notifications', Icons.notifications, NotificationPage()),
                  const SizedBox(height: 10),
                  _buildListTile(context, 'Help', Icons.help, HelpPage()),
                  const SizedBox(height: 10),
                  _buildListTile(context, 'Settings', Icons.settings, SettingsPage()),
                  const SizedBox(height: 10),
                  _buildListTile(context, 'About', Icons.info, AboutPage()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context, String title, IconData icon, Widget page) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
    );
  }
}
