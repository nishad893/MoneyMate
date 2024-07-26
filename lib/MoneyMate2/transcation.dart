import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AddTransaction.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String result) {
              setState(() {
                // Handle result
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'export',
                child: Text('Export to PDF'),
              ),
            ],
          ),
        ],
      ),
      body: TransactionList(firestore: firestore),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Transaction1Page()),
          );
        },
        tooltip: 'Add Transaction',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final FirebaseFirestore firestore;

  const TransactionList({Key? key, required this.firestore}) : super(key: key);

  Future<void> _showDeleteConfirmationDialog(BuildContext context, String docId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Transaction'),
          content: Text('Are you sure you want to delete this transaction?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('transactions')
                    .doc(docId)
                    .delete();
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('transactions').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error.toString()}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Press the + icon to add your first transaction.'));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            bool isExpense = data['type'] == 'Expense';
            Timestamp timestamp = data['timestamp'] as Timestamp;
            DateTime date = timestamp.toDate();
            return Dismissible(
              key: Key(document.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _showDeleteConfirmationDialog(context, document.id);
              },
              background: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              child: ListTile(
                title: Text(
                  data['category'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${data['type']} - ${date.toLocal().toString()}'),
                trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                Text(
                '\$${data['amount'].toStringAsFixed(2)}',
                style: TextStyle(
                  color: isExpense ? Colors.red : Colors.green,
                  fontSize: 16,
                ),
              ),
           ]),
            ),
            );
          }).toList(),
        );
      },
    );
  }
}
