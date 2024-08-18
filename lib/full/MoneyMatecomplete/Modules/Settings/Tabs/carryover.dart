import 'package:flutter/material.dart';

class CarryoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carryover'),
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
              'Balance Carry Over',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text('Carry Over'),
            Switch(
              value: true, // Change to actual state
              onChanged: (bool value) {
                // Handle switch change
              },
            ),
          ],
        ),
      ),
    );
  }
}
