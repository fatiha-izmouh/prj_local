import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  final String whatsappNumber = '+212659449613';

  // Method to launch WhatsApp
  void _launchWhatsApp(BuildContext context) async {
    final whatsappUrl =
        "whatsapp://send?phone=+212$whatsappNumber&text=Hello, I need help!";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("WhatsApp is not installed on your device")),
      );
    }
  }

  // Method to launch the URL
  void _launchTermsOfUse(BuildContext context) async {
    const url = 'https://www.phosboucraa.ma/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.description_outlined, color: Colors.black),
              title: Text(
                'Terms and Privacy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () => _launchTermsOfUse(context), // Launch URL on tap
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock_outline, color: Colors.black),
              title: Text(
                'How to reset password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Tap to see instructions',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('How to reset my password?'),
                      content:
                      Text('Go to settings > security > reset password.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.black),
              title: Text(
                'How to scan QR',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Tap to see instructions',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('How to reset my password?'),
                      content:
                          Text('Go to settings > security > reset password.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Divider(),
            // Help Center with WhatsApp link
            ListTile(
              leading: Icon(Icons.help_outline, color: Colors.black),
              title: Text(
                'Help Center',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Get help, contact us',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              onTap: () {
                _launchWhatsApp(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HelpPage(),
  ));
}
