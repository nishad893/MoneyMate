import 'package:flutter/material.dart';

import 'NewAccountPage.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewAccountPage()),
              );
            },
          ),
        ],
      ),
      body: Center(child: Text('List of Accounts')),
    );
  }
}
