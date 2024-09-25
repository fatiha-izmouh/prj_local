import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<String> notifications = [
    'New comment on your post!',
    'Your password was changed.',
    'New friend request.',
    'System update available.'
  ];

  // Initialize the list to track visibility of hidden texts
  List<bool> _isTextVisible = [];

  @override
  void initState() {
    super.initState();
    // Fill the list with false (hidden) for each notification
    _isTextVisible = List<bool>.filled(notifications.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(notifications[index]),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              // Handle the dismissal of the notification
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.notifications_active, color: Colors.blue),
                  title: Text(notifications[index]),
                  trailing: Icon(Icons.warning, color: Colors.red), // Changed to Icons.warning
                  onTap: () {
                    // Toggle visibility of the hidden text
                    setState(() {
                      _isTextVisible[index] = !_isTextVisible[index];
                    });
                  },
                ),
                // Hidden text that appears when tapped
                if (_isTextVisible[index])
                  Padding(
                    padding: const EdgeInsets.only(left: 70.0), // Indentation
                    child: Text(
                      'Details about "${notifications[index]}"', // Customize this text as needed
                      style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
