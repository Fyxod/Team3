import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Get in Touch',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text('Name'),
                  subtitle: Text('The Finance Corp.'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),
                  title: Text('Mobile Number'),
                  subtitle: Text('+91 89502 91327'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.email, color: Colors.red),
                  title: Text('Email ID'),
                  subtitle: Text('themail@fin.com'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
