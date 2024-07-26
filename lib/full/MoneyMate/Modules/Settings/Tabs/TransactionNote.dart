import 'package:flutter/material.dart';

class TransactionNotePage extends StatefulWidget {
  @override
  _TransactionNotePageState createState() => _TransactionNotePageState();
}

class _TransactionNotePageState extends State<TransactionNotePage> {
  bool _showNote = false;

  void _toggleShowNote(bool value) {
    setState(() {
      _showNote = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Note'),
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
            Text('Show Note'),
            Switch(
              value: _showNote,
              onChanged: _toggleShowNote,
            ),
            SizedBox(height: 20),
            Text(
              'Short Note Instead of Category',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            Text(
              'Turn this on to display the Note instead of the Category name in the Transactions list.',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
