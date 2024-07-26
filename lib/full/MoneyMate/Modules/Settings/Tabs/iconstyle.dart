import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconStyleDialog extends StatefulWidget {
  final String selectedStyle;

  IconStyleDialog({required this.selectedStyle});

  @override
  _IconStyleDialogState createState() => _IconStyleDialogState();
}

class _IconStyleDialogState extends State<IconStyleDialog> {
  late String _selectedStyle;

  @override
  void initState() {
    super.initState();
    _selectedStyle = widget.selectedStyle;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Icon Style'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption('Outline'),
          _buildOption('Filled'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, _selectedStyle);
          },
          child: Text('OK'),
        ),
      ],
    );
  }

  Widget _buildOption(String style) {
    return ListTile(
      title: Text(style),
      trailing: _selectedStyle == style ? Icon(Icons.check, color: Colors.blue) : null,
      onTap: () {
        setState(() {
          _selectedStyle = style;
        });
      },
    );
  }
}