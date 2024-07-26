import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BudgetModePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text("Budget Mode"),
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
            "Budget Mode",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Divider(),
          Row(
            children: [
              Text(
                "Budget Mode",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Switch(
                value: true,
                onChanged: (value) {

                },
                activeColor: Colors.orange,
                inactiveTrackColor: Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Budget Amount",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Include Income",
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              Switch(
                value: true,
                onChanged: (value) {
                  // Handle switch value change
                },
                activeColor: Colors.orange,
                inactiveTrackColor: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}
