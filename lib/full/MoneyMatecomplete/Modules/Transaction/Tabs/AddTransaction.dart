import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../Settings/Tabs/Currency Provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDKK6kO3aR8cLb90qASqcmOP3YhrPBYQm0",
      appId: "1:866409671969:android:ff79734a13ea31dec96260",
      messagingSenderId: "",
      projectId: "moneymate666",
      storageBucket: "moneymate666.appspot.com",
    ),
  );
  runApp(
    Transaction1Page(type: '',),
  );
}
class Transaction1Page extends StatefulWidget {
  final String type;
  Transaction1Page({required this.type});

  @override
  _Transaction1PageState createState() => _Transaction1PageState();
}


class _Transaction1PageState extends State<Transaction1Page> {
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _chatColorController = TextEditingController();
  IconData? selectedIcon;
  late bool _isExpense;
  @override
  void initState() {
    super.initState();
    _isExpense = widget.type == 'Expense'; // Use type parameter
  }
  TextEditingController amountController = TextEditingController();
  TextEditingController additionalFieldController = TextEditingController();// New controller

  String? selectedCategory;
  String? newCategory;
  bool showNewCategoryField = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final List<IconData> icons = [
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
      setState(( ) {
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
  void selectIcon() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Select Icon'),
            content: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                children: icons.map((icon) {
                  return IconButton(
                    icon: Icon(icon),
                    onPressed: () {
                      setState(() {
                        selectedIcon = icon;
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
  Future<void> _saveTransaction() async {
    String categoryName = _categoryNameController.text;
    String chatColor = _chatColorController.text;
    try {
      String userId = 'user123';
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String categoryToSave = selectedCategory == 'Others' ? categoryName : selectedCategory!;

      DateTime now = DateTime.now();
      // String monthString = '${now.year}-${now.month.toString().padLeft(2, '0')}';
       String periodString = '${now.year}-${now.month}-${now.day.toString().padLeft(2, '0')}';

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
        // 'month': monthString,
        'period':periodString,
      });

      if (selectedCategory == 'Others' && categoryName.isNotEmpty&& selectedIcon != null && chatColor.isNotEmpty) {
        DocumentReference docRef = FirebaseFirestore.instance.collection('categories').doc();
        await firestore.collection('categories').add({
          'categoryName': categoryName,
          'icon': selectedIcon!.codePoint,
          'chatColor': chatColor,
          'categoryId': docRef.id
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
                labelText: 'Amount ($currencySymbol)',
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
                // categories.add('Others');

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
                      // showNewCategoryField = selectedCategory == 'Others';
                    });
                  },
                  hint: Text('Select Category', style: TextStyle(color: Colors.orange)),
                );
              },
            ),

          //   if (showNewCategoryField) ...[
          //     TextField(
          //       onChanged: (value) {
          //         setState(() {
          //           newCategory = value;
          //         });
          //       },
          //       decoration: InputDecoration(
          //         labelText: 'Please add your category',
          //         labelStyle: TextStyle(color: Colors.orange),
          //       ),
          //     ),
          //     SizedBox(height: 16),
          //     Row(
          //       children: [
          //         Text('Selected Icon: '),
          //         IconButton(
          //           icon: selectedIcon != null
          //               ? Icon(selectedIcon)
          //               : Icon(Icons.add),
          //           onPressed: selectIcon,
          //         ),
          //       ],
          //     ),
          //   ],
      ]),
      ),
    );
  }
}