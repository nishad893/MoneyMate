import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class NewAccountPage extends StatefulWidget {
  @override
  _NewAccountPageState createState() => _NewAccountPageState();
}

class _NewAccountPageState extends State<NewAccountPage> {
  Color _selectedColor = Colors.blue;

  void _selectColor() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Chat Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _selectedColor,
            onColorChanged: (color) {
              setState(() {
                _selectedColor = color;
              });
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Account'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Save account logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Details',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter the name',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Initialize Amount',
                hintText: 'Current Balance',
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Remarks',
                hintText: 'Account details (e.g., account number, IFSC, location, etc.)',
              ),
              maxLines: null,
              minLines: 1,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Chat Color:'),
                TextButton(
                  onPressed: _selectColor,
                  child: Text('Select Chat Color'),
                ),
                Container(
                  width: 24,
                  height: 24,
                  color: _selectedColor,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'You can add extra Accounts here. For example you may want to have different accounts for different people, or have a separate \'Savings\' account.',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
