import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Modules/Settings/Settings.dart';
import '../Modules/Category/categories.dart';
import '../Modules/Settings/Tabs/Currency Provider.dart';
import '../Modules/Settings/Tabs/TimePeriod.dart';
import '../Modules/Spending/Spending.dart';
import '../Users/Authentication/loginwithmobilenumber.dart';
import '../Modules/Transaction/transcation.dart';

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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrencyProvider()),
        ChangeNotifierProvider(create: (_) => TimePeriodChanger()),
      ],
      child: MoneyMateApp(),
    ),
  );
}

class MoneyMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthenticationWrapper(), // Start with authentication wrapper
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Or loading indicator
        }
        if (snapshot.hasData) {
          User? user = FirebaseAuth.instance.currentUser;
          String uid = user!.uid;
          return MoneyMatehome(uid: uid); // Navigate to home with uid
        } else {
          return MobileOtp(); // Navigate to authentication screen
        }
      },
    );
  }
}

class MoneyMatehome extends StatefulWidget {
  final String uid;

  MoneyMatehome({required this.uid});

  @override
  _MoneyMatehomeState createState() => _MoneyMatehomeState();
}

class _MoneyMatehomeState extends State<MoneyMatehome> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    SpendingPage(),
    TransactionPage(),
    CategoriesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey[800],
        unselectedLabelStyle: TextStyle(color: Colors.grey[800]),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Spending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        onTap: _onItemTapped,
      ),
    );
  }
}
