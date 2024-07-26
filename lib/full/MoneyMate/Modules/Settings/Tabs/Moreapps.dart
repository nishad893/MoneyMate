import 'package:flutter/material.dart';

class MoreAppsPage extends StatelessWidget {
  void _openWebsite() {
    // Logic to open website
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Apps'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('App 1'),
            subtitle: Text('Description of App 1'),
            trailing: Image.asset('assets/app1_icon.png'),
            onTap: _openWebsite,
          ),
          ListTile(
            title: Text('App 2'),
            subtitle: Text('Description of App 2'),
            trailing: Image.asset('assets/app2_icon.png'),
            onTap: _openWebsite,
          ),
          ListTile(
            title: Text('App 3'),
            subtitle: Text('Description of App 3'),
            trailing: Image.asset('assets/app3_icon.png'),
            onTap: _openWebsite,
          ),
        ],
      ),
    );
  }
}
