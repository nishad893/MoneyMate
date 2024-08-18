import 'package:flutter/material.dart';

class SelectFontPage extends StatelessWidget {
  void _showFontSelector(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Font 1'),
              onTap: () {
                // Select font logic
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Font 2'),
              onTap: () {
                // Select font logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Languages and Fonts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Summary Font'),
            trailing: Text('Font 1'), // Display selected font
            onTap: () => _showFontSelector(context, 'Select Summary Font'),
          ),
          ListTile(
            title: Text('Transaction Font'),
            trailing: Text('Font 2'), // Display selected font
            onTap: () => _showFontSelector(context, 'Select Transaction Font'),
          ),
          ListTile(
            title: Text('App Language'),
            trailing: Text('English'), // Display selected language
            onTap: () => _showFontSelector(context, 'Select App Language'),
          ),
        ],
      ),
    );
  }
}
