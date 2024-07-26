import 'package:flutter/material.dart';

class DataPrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data and Privacy'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Privacy Policy'),
            onTap: () {
              // Navigate to Privacy Policy
            },
          ),
          ListTile(
            title: Text('Mobile Identifier Policy'),
            onTap: () {
              // Navigate to Mobile Identifier Policy
            },
          ),
          ListTile(
            title: Text('Privacy Query'),
            onTap: () {
              // Navigate to Privacy Query
            },
          ),
          SwitchListTile(
            title: Text('Disable Crash Logs'),
            value: true,
            onChanged: (bool value) {
              // Toggle disable crash logs
            },
          ),
          Divider(),
          ListTile(
            title: Text('Send Logs'),
            onTap: () {
              // Send logs
            },
          ),
          ListTile(
            title: Text('Send Data'),
            onTap: () {
              // Send data
            },
          ),
        ],
      ),
    );
  }
}
