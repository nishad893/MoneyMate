import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  bool _showSummary = false;

  void _toggleShowSummary(bool value) {
    setState(() {
      _showSummary = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widgets'),
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
            Text('Show Summary'),
            Switch(
              value: _showSummary,
              onChanged: _toggleShowSummary,
            ),
            SizedBox(height: 20),
            Text(
              'Turn this on to show the spending summary in your Widgets. Due to the limitations of widgets, the summary can only be updated when you use the app.',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
