import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  String _frequency = 'Every day';
  TimeOfDay _timeOfDay = TimeOfDay.now();

  void _selectFrequency() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        children: [
          ListTile(
            title: Text('Every week'),
            onTap: () {
              setState(() {
                _frequency = 'Every week';
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Every day'),
            onTap: () {
              setState(() {
                _frequency = 'Every day';
              });
              Navigator.pop(context);
            },
          ),
          // Add more ListTile widgets for other frequencies
        ],
      ),
    );
  }

  void _selectTimeOfDay() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _timeOfDay,
    );
    if (picked != null && picked != _timeOfDay) {
      setState(() {
        _timeOfDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Save reminder logic
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Frequency'),
              trailing: Text(_frequency),
              onTap: _selectFrequency,
            ),
            ListTile(
              title: Text('Time of the Day'),
              trailing: Text(_timeOfDay.format(context)),
              onTap: _selectTimeOfDay,
            ),
          ],
        ),
      ),
    );
  }
}
