import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../Settings/Tabs/Currency Provider.dart';

class Transaction1Page extends StatefulWidget {
  @override
  _Transaction1PageState createState() => _Transaction1PageState();
}

class _Transaction1PageState extends State<Transaction1Page> {
  bool _isExpense = true;
  TextEditingController amountController = TextEditingController();
  TextEditingController additionalFieldController = TextEditingController(); // New controller
  String? selectedCategory;
  String? newCategory;
  String? selectedIcon;
  bool showNewCategoryField = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final List<String> icons = ['Icon1', 'Icon2', 'Icon3', 'Icon4']; // List of icons

  void _toggleTransactionType() {
    setState(() {
      _isExpense = !_isExpense;
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveTransaction() async {
    try {
      String userId = 'user123';
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String categoryToSave = selectedCategory == 'Others' ? newCategory! : selectedCategory!;
      DateTime now = DateTime.now();
      String monthString = '${now.year}-${now.month.toString().padLeft(2, '0')}';

      await firestore.collection('transactions').add({
        'userId': userId,
        'type': _isExpense ? 'Expense' : 'Income',
        'amount': double.parse(amountController.text),
        'category': categoryToSave,
        'timestamp': Timestamp.fromDate(DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        )),
        'month': monthString,
      });

      if (selectedCategory == 'Others' && newCategory!.isNotEmpty) {
        await firestore.collection('categories').add({
          'categoryName': newCategory,
          'icon': selectedIcon ?? 'Icon1',
          'chatColor': '#FFFFFF',
        });
      }

      Navigator.pop(context);
    } catch (e) {
      print('Error saving transaction: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    String currencySymbol=Provider.of<CurrencyProvider>(context).currencySymbol;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Transaction'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _saveTransaction,
          ),
        ],
      ),
      body: SingleChildScrollView( // Make the content scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Transaction Details',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isExpense ? null : _toggleTransactionType,
                    child: Text('Expense',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 17),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return _isExpense ? Colors.orange : Colors.grey;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isExpense ? _toggleTransactionType : null,
                    child: Text('Income',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17),),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return _isExpense ? Colors.grey : Colors.orange;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _selectDate,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: '${_selectedDate.toLocal()}'.split('')[0],
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: _selectTime,
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Time',
                    hintText: _selectedTime.format(context),
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: additionalFieldController, // New field controller
              decoration: InputDecoration(
                labelText: 'Additional Info',
                labelStyle: TextStyle(color: Colors.orange),
                hintText: 'Enter additional information here',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: TextStyle(color: Colors.orange),
                hintText: 'Enter Your Amount',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Text(
              'Category',
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('categories').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                final categories = snapshot.data!.docs.map((doc) => doc['categoryName'] as String).toList();
                categories.add('Others');

                // Ensure selectedCategory is valid
                if (selectedCategory == null || !categories.contains(selectedCategory)) {
                  selectedCategory = categories.first;
                }

                return DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCategory,
                  items: categories.toSet().map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value!;
                      showNewCategoryField = selectedCategory == 'Others';
                    });
                  },
                  hint: Text('Select Category', style: TextStyle(color: Colors.orange)),
                );
              },
            ),
            if (showNewCategoryField) ...[
              TextField(
                onChanged: (value) {
                  setState(() {
                    newCategory = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Please add your category',
                  labelStyle: TextStyle(color: Colors.orange),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Select Icon',
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
              DropdownButton<String>(
                isExpanded: true,
                value: selectedIcon,
                items: icons.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedIcon = value!;
                  });
                },
                hint: Text('Select Icon'),
                style: TextStyle(color: Colors.orange),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
