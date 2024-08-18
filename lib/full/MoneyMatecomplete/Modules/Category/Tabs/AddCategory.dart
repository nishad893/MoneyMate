import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddCategoryPage extends StatefulWidget {
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  Color _selectedColor = Colors.blue;
  final TextEditingController _categoryNameController = TextEditingController();
  IconData? _selectedIcon;
  final TextEditingController _chatColorController = TextEditingController();

  final List<IconData> _icons = [
    Icons.home,
    Icons.star,
    Icons.work,
    Icons.school,
    Icons.fitness_center,
    Icons.local_grocery_store,
    Icons.money,
    Icons.wifi,
    Icons.hotel,
    Icons.emoji_food_beverage,
    CupertinoIcons.car,
    Icons.business_sharp,
    Icons.pets,
    Icons.mosque,
    CupertinoIcons.circle_grid_3x3,
  ];

  @override
  void initState() {
    super.initState();
    _chatColorController.text =
    '#${_selectedColor.value.toRadixString(16).substring(2)}';
  }

  void _selectColor() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Select Chat Color'),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: _selectedColor,
                onColorChanged: (color) {
                  setState(() {
                    _selectedColor = color;
                    _chatColorController.text =
                    '#${_selectedColor.value.toRadixString(16).substring(2)}';
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
    );
  }

  void _selectIcon() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Select Icon'),
            content: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                children: _icons.map((icon) {
                  return IconButton(
                    icon: Icon(icon),
                    onPressed: () {
                      setState(() {
                        _selectedIcon = icon;
                      });
                      Navigator.of(context).pop();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
    );
  }

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
            Row(
              children: [
                Text('Selected Icon: '),
                IconButton(
                  icon: _selectedIcon != null
                      ? Icon(_selectedIcon)
                      : Icon(Icons.add),
                  onPressed: _selectIcon,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatColorController,
                    readOnly: true,
                    decoration: InputDecoration(labelText: 'Icon Color'),
                  ),
                ),
                TextButton(
                  onPressed: _selectColor,
                  child: Text('Select Icon Color'),
                ),
                Container(
                  width: 24,
                  height: 24,
                  color: _selectedColor,
                ),
              ],
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
      // Create a new document reference
      DocumentReference docRef = FirebaseFirestore.instance.collection('categories').doc();

      // Set the data, including the categoryId
      await docRef.set({
        'categoryName': categoryName,
        'icon': _selectedIcon!.codePoint,
        'chatColor': chatColor,
        'categoryId': docRef.id, // Automatically set categoryId to the document ID
      });

      // Optionally handle post-save actions
      Navigator.pop(context);
    } else {
      // Show an error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  // void _saveCategory() async {
  //   String categoryName = _categoryNameController.text;
  //   String chatColor = _chatColorController.text;
  //
  //   if (categoryName.isNotEmpty && _selectedIcon != null &&
  //       chatColor.isNotEmpty) {
  //     DocumentReference docRef = await FirebaseFirestore.instance.collection(
  //         'categories').add({
  //       'categoryName': categoryName,
  //       'icon': _selectedIcon!.codePoint,
  //       'chatColor': chatColor,
  //     });
  //
  //     // Update the document with the categoryId
  //     await docRef.update({'categoryId': docRef.id});
  //
  //     Navigator.pop(context);
  //   } else {
  //     // Show an error message or handle invalid input
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Please fill in all fields')),
  //     );
  //   }
  // }
}
