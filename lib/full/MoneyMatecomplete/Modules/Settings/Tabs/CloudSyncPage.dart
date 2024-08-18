import 'package:flutter/material.dart';

class CloudSyncPage extends StatelessWidget {
  void _showDeDuplicateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Query'),
        content: Text(
            'As you are not linked to any of these accounts, it will not be possible to create a backup of your data before de-duplicating. Are you sure you want to continue?'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Info'),
                  content: Text(
                      'A backup was created before de-duplicating, so if you need to restore you can do so from the \'Settings -> Backups\' screen.'
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Text('De-Duplicate'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cloud Sync'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Link with Google Drive', icon: Image.asset('assets/google_drive.png', width: 20)),
                Tab(text: 'Link with iCloud', icon: Image.asset('assets/icloud.png', width: 20)),
                Tab(text: 'Link with Dropbox', icon: Image.asset('assets/dropbox.png', width: 20)),
                Tab(text: 'Link with OneDrive', icon: Image.asset('assets/onedrive.png', width: 20)),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'You will need an account to sync your data. Use the \'Link\' button above to connect to or create a new account.',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _showDeDuplicateDialog(context),
              child: Text('De-Duplicate'),
            ),
          ],
        ),
      ),
    );
  }
}
