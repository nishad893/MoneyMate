import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Users/Login/MoneymateLogin.dart';
import '../Settings/Tabs/Currency Provider.dart';
import '../Settings/Tabs/TimePeriod.dart';
import '../Transaction/Tabs/AddTransaction.dart';


class SpendingPage extends StatefulWidget {
  const SpendingPage({super.key});

  @override
  State<SpendingPage> createState() => _SpendingPageState();
}

class _SpendingPageState extends State<SpendingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  double income = 0.0;
  double expenses = 0.0;
  double balance = 0.0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // void _loadData() async {
  //   try {
  //     String periodString = _getPeriodString();
  //
  //     QuerySnapshot snapshot = await firestore.collection('transactions')
  //         .where('period', isEqualTo: periodString)
  //         .get();
  //
  //     double tempIncome = 0.0;
  //     double tempExpenses = 0.0;
  //
  //     snapshot.docs.forEach((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       if (data['type'] == 'Income') {
  //         tempIncome += data['amount'];
  //       } else if (data['type'] == 'Expense') {
  //         tempExpenses += data['amount'];
  //       }
  //     });
  //
  //     setState(() {
  //       income = tempIncome;
  //       expenses = tempExpenses;
  //       balance = income - expenses;
  //     });
  //   } catch (e) {
  //     print("Error fetching data: $e");
  //     // Handle the error (e.g., show an error message to the user)
  //   }
  // }
  void _loadData() async {
    try {
      String periodString = _getPeriodString();
      print("Fetching data for period: $periodString");

      QuerySnapshot snapshot = await firestore.collection('transactions')
          .where('period', isEqualTo: periodString)
          .get();

      print("Fetched ${snapshot.docs.length} documents");

      double tempIncome = 0.0;
      double tempExpenses = 0.0;

      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        print("Document data: $data");
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
        print("Income: $income, Expenses: $expenses, Balance: $balance");
      });
    } catch (e) {
      print("Error fetching data: $e");
      // Handle the error (e.g., show an error message to the user)
    }
  }

  String _getPeriodString() {
    return "${selectedDate.year}-${selectedDate.month}-${selectedDate.day.toString().padLeft(2, '0')}";
  }

  void _changeDate(int increment) {
    setState(() {
      selectedDate = DateTime(selectedDate.year, selectedDate.month + increment, selectedDate.day);
      _loadData();
    });
  }

  void _navigateToAddTransaction(String type) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Transaction1Page(type: '',),
      ),
    );
    _loadData(); // Refresh data after returning from AddTransactionPage
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    String currencySymbol = Provider.of<CurrencyProvider>(context).currencySymbol;
    TimePeriod timePeriod = Provider.of<TimePeriodChanger>(context).selectedPeriod;

    String dateDisplay;
    switch (timePeriod) {
      case TimePeriod.daily:
        dateDisplay = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
        break;
      case TimePeriod.monthly:
        dateDisplay = '${selectedDate.month}/${selectedDate.year}';
        break;
      case TimePeriod.yearly:
        dateDisplay = '${selectedDate.year}';
        break;
      default:
        dateDisplay = '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
                _showSignOutDialog(context);
                },
              icon: Icon(Icons.logout, color: Colors.brown, size: 40),
            ),
            SizedBox(width: screenSize.width * 0.07),
            IconButton(
              icon: Icon(CupertinoIcons.back, color: Colors.orange),
              onPressed: () => _changeDate(-1),
            ),
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
                dateDisplay,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
              ),
            ),
            IconButton(
              icon: Icon(CupertinoIcons.forward, color: Colors.orange),
              onPressed: () => _changeDate(1),
            ),
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: Colors.black,
              thickness: .1,),
              SizedBox(height: screenSize.height * 0.02),
              Container(
                height: screenSize.height * 0.04,
                width: screenSize.width * 0.79,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(screenSize.height * 0.02),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: screenSize.height * 0.04,
                      width: screenSize.width * 0.79 * (income == 0 ? 0 : expenses / income),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(screenSize.height * 0.02),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.015),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.19),
                  Text("Income", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight:FontWeight.bold)),
                  SizedBox(width: screenSize.width * 0.35),
                  Text("$currencySymbol${income.toStringAsFixed(2)}", style: TextStyle(color: Colors.green, fontSize: 17,fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: screenSize.height * 0.018),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.18),
                  Text("Expense", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold)),
                  SizedBox(width: screenSize.width * 0.34),
                  Text("$currencySymbol${expenses.toStringAsFixed(2)}", style: TextStyle(color: Colors.red, fontSize: 17,fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: screenSize.height * 0.018),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.07),
                child: Divider(color: Colors.black),
              ),
              SizedBox(height: screenSize.height * 0.01),
              Row(
                children: [
                  SizedBox(width: screenSize.width * 0.18),
                  Text("Balance", style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold)),
                  SizedBox(width: screenSize.width * 0.35),
                  Text("$currencySymbol${balance.toStringAsFixed(2)}", style: TextStyle(

                      color: Colors.blue[500], fontSize: 17,fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: screenSize.height * 0.2),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.195, left: screenSize.width * 0.035),
                child: Row(
                  children: [
                     SizedBox(width: screenSize.width * 0.05),

                    ElevatedButton(onPressed: () => _navigateToAddTransaction('Expense'),

                        child: Text("+Expense",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 17),)),
                    SizedBox(width: screenSize.width * 0.25),
                    ElevatedButton(
                        // style: TextButton.styleFrom(
                        //   backgroundColor: Colors.orange,
                        // ),
                        onPressed: () => _navigateToAddTransaction('Income'),

                        child: Text("+Income",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 17),)),
                    SizedBox(width: screenSize.width * 0.04),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.07),
              Text(
                "** Rotate device to view reports **",
                style: TextStyle(fontSize: 12, color: Colors.grey[800]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSignOutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ); // Navigate to login screen
            },
            child: Text('Sure'),
          ),
        ],
      );
    },
  );
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAesQHw2Jb4cQG7Z_kr91wTIwdX5Fq2k18",
      appId: "1:397478883162:android:af509b2925b5eaf2fccd63",
      messagingSenderId: "",
      projectId: "moneymate2-fdfaf",
      storageBucket: "moneymate2-fdfaf.appspot.com",
    ),
  );
  runApp(
    SpendingPage(),
  );
}