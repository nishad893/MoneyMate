import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final TextEditingController _categoryNameController = TextEditingController();
  String? _selectedIcon;
  final TextEditingController _chatColorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              items: <String>['Icon1', 'Icon2', 'Icon3'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedIcon = newValue;
                });
              },
              hint: Text('Select Icon'),
              value: _selectedIcon,
            ),
            TextField(
              controller: _chatColorController,
              decoration: InputDecoration(
                labelText: 'Chat Color',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveCategory,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveCategory() async {
    String categoryName = _categoryNameController.text;
    String chatColor = _chatColorController.text;

    if (categoryName.isNotEmpty && _selectedIcon != null && chatColor.isNotEmpty) {
      await FirebaseFirestore.instance.collection('categories').add({
        'categoryName': categoryName,
        'icon': _selectedIcon,
        'chatColor': chatColor,
      });
      Navigator.pop(context);
    } else {
      // Show an error message or handle invalid input
    }
  }
}
