import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'AddTransaction.dart';

class SpendingPage extends StatefulWidget {
  const SpendingPage({super.key});

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime selectedMonth = DateTime.now();
  double income = 0.0;
  double expenses = 0.0;
  double balance = 0.0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() async {
    String monthString = '${selectedMonth.year}-${selectedMonth.month.toString().padLeft(2, '0')}';

    QuerySnapshot snapshot = await firestore.collection('transactions')
        .where('month', isEqualTo: monthString)
        .get();

    double tempIncome = 0.0;
    double tempExpenses = 0.0;

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['type'] == 'Income') {
        tempIncome += data['amount'];
      } else if (data['type'] == 'Expense') {
        tempExpenses += data['amount'];
      }
    });

    setState(() {
      income = tempIncome;
      expenses = tempExpenses;
      balance = income - expenses;
    });
  }

  void _changeMonth(int increment) {
    setState(() {
      selectedMonth = DateTime(selectedMonth.year, selectedMonth.month + increment, 1);
      _loadData();
    });
  }

  void _navigateToAddTransaction(String type) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Transaction1Page(),
      ),
    );
    _loadData(); // Refresh data after returning from AddTransactionPage
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(CupertinoIcons.question_circle, color: Colors.brown, size: 40),
            ),
            SizedBox(width: screenSize.width * 0.2),
            Container(
              height: 30,
              width: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.brown),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '${selectedMonth.month}/${selectedMonth.year}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black
          ,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: screenSize.width * 0.35),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.back, color: Colors.white),
                    onPressed: () => _changeMonth(-1),
                  ),
                  SizedBox(width: screenSize.width * 0.05),
                  IconButton(
                    icon: Icon(CupertinoIcons.forward, color: Colors.white),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Container(
              height: screenSize.height * 0.04,
              width: screenSize.width * 0.77 ,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(screenSize.height * 0.02),
              ),
              child: Stack(
                children: [
                  Container(
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.77 * (income == 0 ? 0 : expenses / income),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(screenSize.height * 0.02),
                    ),
                  ),
                ],
              ),
            )
            ,SizedBox(height: screenSize.height * 0.015),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text("Income", style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(width: screenSize.width * 0.35),
                Text("   ${ income.toStringAsFixed(2)}", style: TextStyle(color: Colors.green, fontSize: 15)),
                //

              ],
            ),
            SizedBox(height: screenSize.height * 0.015),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text("Expense", style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(width: screenSize.width * 0.35),
                Text("${expenses.toStringAsFixed(2)}", style: TextStyle(color: Colors.red, fontSize: 15)),
                Icon(Icons.attach_money, color: Colors.red, size: 17),
              ],
            ),
            SizedBox(height: screenSize.height * 0.018),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
              child: Divider(color: Colors.white),
            ),
            SizedBox(height: screenSize.height * 0.01),
            Row(
              children: [
                SizedBox(width: screenSize.width * 0.1),
                Text("Balance", style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(width: screenSize.width * 0.35),
                Text("${balance.toStringAsFixed(2)}", style: TextStyle(color: Colors.blue[100], fontSize: 15)),
                Icon(Icons.attach_money, color: Colors.blue, size: 17),
              ],
            ),

            SizedBox(height: screenSize.height*0.2,),


            Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.195, left: screenSize.width * 0.035),
              child: Row(
                children: [
                  SizedBox(width: screenSize.width*0.05 ,),
                  Container(
                    alignment: Alignment.center,
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(screenSize.height * 0.025),
                    ),
                    child: TextButton(
                      onPressed: () => _navigateToAddTransaction('Expense'),
                      child: Text("+ Expense", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  SizedBox(width: screenSize.width * 0.35),
                  Container(
                    alignment: Alignment.center,
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.24,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(screenSize.height * 0.025),
                    ),
                    child: TextButton(
                      onPressed: () => _navigateToAddTransaction('Income'),
                      child: Text("+ Income", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  SizedBox(width: screenSize.width*0.04,)
                ],
              ),
            ),
            SizedBox(height: screenSize.height * 0.07),
            Text(
              "** Rotate device to view reports **",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
