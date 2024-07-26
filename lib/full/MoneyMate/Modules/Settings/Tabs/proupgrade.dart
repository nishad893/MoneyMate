import 'package:flutter/material.dart';

class ProUpgradePage extends StatefulWidget {
  @override
  _ProUpgradePageState createState() => _ProUpgradePageState();
}

class _ProUpgradePageState extends State<ProUpgradePage> {
  void _restorePurchase() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Processing'),
        content: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pro Upgrade'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: _restorePurchase,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/upgrade_image.png', height: 200), // Example image
            ListTile(
              leading: Icon(Icons.featured_play_list),
              title: Text('Feature 1'),
              subtitle: Text('Description of feature 1'),
            ),
            ListTile(
              leading: Icon(Icons.featured_play_list),
              title: Text('Feature 2'),
              subtitle: Text('Description of feature 2'),
            ),
            // Add more ListTile widgets for other features
          ],
        ),
      ),
    );
  }
}
