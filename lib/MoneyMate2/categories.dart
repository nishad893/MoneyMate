import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AddCategory.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  Future<void> _showDeleteConfirmationDialog(BuildContext context, String docId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Category'),
          content: Text('Are you sure you want to delete this category?'),
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
                    .collection('categories')
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {
        //       // Edit action
        //     },
        //   ),
        // ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('categories').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final categories = snapshot.data!.docs;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              var category = categories[index];
              return Dismissible(
                key: Key(category.id),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  _showDeleteConfirmationDialog(context, category.id);
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
                  leading: Icon(Icons.category), // You can use category icons here
                  title: Text(category['categoryName']),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCategoryPage()),
          );
        },
        tooltip: 'Add Category',
        child: Icon(Icons.add),
      ),
    );
  }
}
