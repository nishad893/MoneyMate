import 'package:flutter/material.dart';

class PasscodePage extends StatelessWidget {
  void _showPasscodeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Query'),
        content: Text(
            'Would you like to use Face ID/ Finger Print to access Money Mate? Please note that you will still need to create a Passcode as a fallback method of access.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No Thanks'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Processing'),
                  content: CircularProgressIndicator(),
                ),
              );
            },
            child: Text('Use'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passcode'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showPasscodeDialog(context),
          child: Text('Set Passcode'),
        ),
      ),
    );
  }
}
