import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Tabs/AddCategory.dart';

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
              int iconCodePoint;
              Color chatColor;

              try {
                iconCodePoint = category['icon'];
                chatColor = Color(int.parse(category['chatColor'].substring(1, 7), radix: 16) + 0xFF000000);
              } catch (e) {
                print("Error parsing category data: $e");
                return ListTile(
                  title: Text('Error loading category'),
                  subtitle: Text('Please check your data format in Firestore'),
                );
              }

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
                  leading: Icon(IconData(iconCodePoint, fontFamily: 'MaterialIcons'), color: chatColor),
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

