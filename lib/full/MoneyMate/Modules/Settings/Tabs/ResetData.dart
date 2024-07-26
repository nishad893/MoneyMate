import 'package:flutter/material.dart';

class ResetDataPage extends StatefulWidget {
  @override
  _ResetDataPageState createState() => _ResetDataPageState();
}

class _ResetDataPageState extends State<ResetDataPage> {
  bool _keepCategories = true;

  void _showResetConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Query'),
        content: Text(
            'You are about to "permanently" delete all your transactions, but keep your customized categories. This cannot be undone, are you sure you want to continue?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Logic to reset data
            },
            child: Text('Reset Data'),
          ),
        ],
      ),
    );
  }

  void _showRecoveryOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: [
          ListTile(
            title: Text('Local Backup'),
            onTap: () {
              // Recover from local backup
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Cloud Backup'),
            onTap: () {
              // Recover from cloud backup
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Cancel'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Data'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _showRecoveryOptions,
            child: Text(
              'Recover',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reset Options'),
            SwitchListTile(
              title: Text('Keep Categories'),
              value: _keepCategories,
              onChanged: (bool value) {
                setState(() {
                  _keepCategories = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showResetConfirmationDialog,
              child: Text('Reset Data'),
            ),
          ],
        ),
      ),
    );
  }
}
