import 'package:flutter/material.dart';

class DarkModePage extends StatefulWidget {
  @override
  _DarkModePageState createState() => _DarkModePageState();
}

class _DarkModePageState extends State<DarkModePage> {
  String _selectedMode = 'Off';

  void _changeMode(String mode) {
    setState(() {
      _selectedMode = mode;
    });

    if (mode == 'On') {
      // Change to dark mode
    } else if (mode == 'Off') {
      // Change to light mode
    } else if (mode == 'Auto') {
      // Change based on device settings
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dark Mode'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Off'),
              trailing: _selectedMode == 'Off' ? Icon(Icons.check) : null,
              onTap: () => _changeMode('Off'),
            ),
            ListTile(
              title: Text('On'),
              trailing: _selectedMode == 'On' ? Icon(Icons.check) : null,
              onTap: () => _changeMode('On'),
            ),
            ListTile(
              title: Text('Auto'),
              trailing: _selectedMode == 'Auto' ? Icon(Icons.check) : null,
              onTap: () => _changeMode('Auto'),
            ),
          ],
        ),
      ),
    );
  }
}
