import 'package:flutter/material.dart';

class HideFutureTransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hide Future'),
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
            Text(
              'Hide Future Transactions',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text('Hide Future'),
            Switch(
              value: true, // Change to actual state
              onChanged: (bool value) {
                // Handle switch change
              },
            ),
            SizedBox(height: 20),
            Text(
              'Turn this on to hide any future Expense or Income Transactions. The Balance for the current Time Period will then be today\'s Balance.',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
