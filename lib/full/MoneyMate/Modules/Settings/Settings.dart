import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:moneymate2/full/MoneyMate/Modules/Settings/Tabs/Darkmode.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';

import 'Accounts/AccountsHomePage.dart';
import 'Tabs/Budgetmode.dart';
import 'Tabs/CloudSyncPage.dart';
import 'Tabs/Currency Provider.dart';
import 'Tabs/DataandPrivacy.dart';
import 'Tabs/HideFutureTransaction.dart';
import 'Tabs/Moreapps.dart';
import 'Tabs/Reminderpage.dart';
import 'Tabs/ResetData.dart';
import 'Tabs/SelectFontpage.dart';
import 'Tabs/TimePeriod.dart';
import 'Tabs/TransactionNote.dart';
import 'Tabs/Widgetpage.dart';
import 'Tabs/carryover.dart';
import 'Tabs/iconstyle.dart';
import 'Tabs/passcode.dart';
import 'Tabs/proupgrade.dart';


class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSwitched = false;
  String _selectedStyle = 'Outline';

  void _showIconStyleDialog() async {
    final selectedStyle = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return IconStyleDialog(selectedStyle: _selectedStyle);
      },
    );

    if (selectedStyle != null) {
      setState(() {
        _selectedStyle = selectedStyle;
      });
    }
  }

  void _onSwipe(bool value) {
    setState(() {
      _isSwitched = value;
      if (_isSwitched) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BudgetModePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Consumer2<CurrencyProvider, TimePeriodChanger>(
        builder: (context, currencyProvider, timePeriodChanger, child) {
      String currencySymbol = currencyProvider.currencySymbol;
      return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: height / 4.2,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.orange,
                              width: double.infinity,
                              height: height / 33,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Spending",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Container(
                            width: double.infinity,
                            height: height / 28,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Time Period",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16,),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 28,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          timePeriodChanger
                                              .selectedPeriodString,
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<TimePeriod>(
                                    onSelected: (TimePeriod period) {
                                      timePeriodChanger.setPeriod(period);
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      PopupMenuItem<TimePeriod>(
                                        value: TimePeriod.daily,
                                        child: Text('Daily'),
                                      ),
                                      PopupMenuItem<TimePeriod>(
                                        value: TimePeriod.monthly,
                                        child: Text('Monthly'),
                                      ),
                                      PopupMenuItem<TimePeriod>(
                                        value: TimePeriod.yearly,
                                        child: Text('Yearly'),
                                      ),
                                    ],
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Colors.black,
                            thickness: .2,
                          ),
                          Container(
                            width: double.infinity,
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Budget Mode",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16,),
                                  ),
                                  Spacer(),
                                  SlidingSwitch(
                                    background: _isSwitched
                                        ? Colors.orange
                                        : Colors.grey,
                                    textOff: "",
                                    textOn: "",
                                    value: _isSwitched,
                                    width: 50,
                                    onChanged: (bool value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BudgetModePage()),
                                      );
                                      setState(() {
                                        _isSwitched = value;
                                      });
                                    },
                                    onTap: () {},
                                    onDoubleTap: () {},
                                    onSwipe: (bool value) {
                                      _onSwipe(value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Colors.black,
                            thickness: .2,
                          ),
                          Container(
                            width: double.infinity,
                            height: 30,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Carry Over",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16,),
                                  ),
                                  Spacer(),
                                  SlidingSwitch(
                                    background: Colors.grey,
                                    textOff: "",
                                    textOn: "",
                                    value: false,
                                    width: 50,
                                    onChanged: (bool value) {
                                      if (value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CarryoverPage()),
                                        );
                                      }
                                    },
                                    onTap: () {},
                                    onDoubleTap: () {},
                                    onSwipe: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Colors.black,
                            thickness: .3,
                          ),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Hide Future Transaction",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    SlidingSwitch(
                                      background: Colors.grey,
                                      textOff: "",
                                      textOn: "",
                                      value: false,
                                      width: 50,
                                      onChanged: (bool value) {
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HideFutureTransactionsPage()),
                                          );
                                        }
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 59,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.orange,
                              width: double.infinity,
                              height: 25,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Account Management",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Accounts",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AccountsPage()),
                                          );
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 55,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(

                              color: Colors.orange,
                              width: double.infinity,
                              height: 25,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Automatic Syncing",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Cloud sync",
                                      style: TextStyle(
                                          color:Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    SlidingSwitch(
                                      background: Colors.grey,
                                      textOff: "",
                                      textOn: "",
                                      value: false,
                                      width: 50,
                                      onChanged: (bool value) {
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CloudSyncPage()),
                                          );
                                        }
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: height / 4.27,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.orange,
                              width: double.infinity,
                              height: 25,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "User Iterface",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Dark Mode",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    SlidingSwitch(
                                      background: Colors.grey,
                                      textOff: "",
                                      textOn: "",
                                      value: false,
                                      width: 50,
                                      onChanged: (bool value) {
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DarkModePage()),
                                          );
                                        }
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .2,
                          ),
                          Container(
                            width: double.infinity,
                            height: 40,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showCurrencyPicker(
                                        context: context,
                                        showFlag: true,
                                        showSearchField: true,
                                        showCurrencyName: true,
                                        showCurrencyCode: true,
                                        favorite: ['eur'],
                                        onSelect: (Currency currency) {
                                          currencyProvider.setCurrencySymbol(
                                              currency.symbol);
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 2),
                                          child: Text(
                                            'Change Currency',
                                            style:
                                                TextStyle(color: Colors.black,fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(currencySymbol,
                                            style: TextStyle(fontSize: 20,color: Colors.red)),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Text(
                                      currencySymbol,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20,),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Colors.black,
                            thickness: .2,
                          ),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Show Transaction Note",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    SlidingSwitch(
                                      background: Colors.grey,
                                      textOff: "",
                                      textOn: "",
                                      value: false,
                                      width: 50,
                                      onChanged: (bool value) {
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TransactionNotePage()),
                                          );
                                        }
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .3,
                          ),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Summary Font",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),

                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SelectFontPage()),
                                          );
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                          // Divider(
                          //   thickness: .3,
                          // ),
                          // Container(
                          //   width: double.infinity,
                          //   height: height/8,
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(10),
                          //     child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text(
                          //           "Category Icon Style",
                          //           style: TextStyle(
                          //               color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
                          //         ),
                          //         Spacer(),
                          //         Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Text(
                          //               "Selected Style: $_selectedStyle",
                          //               style: TextStyle(
                          //                   fontSize: 16, color: Colors.blue),
                          //             ),
                          //             SizedBox(height: 10),
                          //             Padding(
                          //               padding:
                          //                   const EdgeInsets.only(left: 20,bottom: 20),
                          //               child: ElevatedButton(
                          //                 style: ButtonStyle(
                          //
                          //                 ),
                          //                 onPressed: _showIconStyleDialog,
                          //                 child: Text("Select Icon Style"),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 245,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.orange,
                              width: double.infinity,
                              height: 25,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "Genaral",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Pro Upgrade",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Not Upgraded",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProUpgradePage()));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .2,
                          ),
                          Container(
                              width: double.infinity,
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Remainder",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "daily",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.blue),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RemindersPage()));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .6,
                          ),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Auto Backup",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),

                                    // Text("Off",style: TextStyle(fontSize: 18,color: Colors.white70),),
                                    // IconButton(onPressed: (){}, icon:Icon(CupertinoIcons.forward,color: Colors.grey,))
                                    SlidingSwitch(
                                      background: Colors.grey,
                                      textOff: "",
                                      textOn: "",
                                      value: false,
                                      width: 50,
                                      onChanged: (bool value) {
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CloudSyncPage()),
                                          );
                                        }
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .6,
                          ),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Widget",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WidgetPage()));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .6,
                          ),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "Passcode",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    SlidingSwitch(
                                      background: Colors.grey,
                                      colorOff: Colors.red,
                                      colorOn: Colors.green,
                                      textOff: "",
                                      textOn: "",
                                      value: false,
                                      width: 50,
                                      onChanged: (bool value) {
                                        if (value) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PasscodePage()),
                                          );
                                        }
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 110,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              color: Colors.orange,
                              width: double.infinity,
                              height: 25,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  "About",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Container(
                              width: double.infinity,
                              height: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(
                                      "More Apps",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 16,),
                                    ),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MoreAppsPage()));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                          Divider(color: Colors.black,
                            thickness: .2,
                          ),
                          Container(
                              width: double.infinity,
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text("Data & Privacy",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,)),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DataPrivacyPage()));
                                        },
                                        icon: Icon(
                                          CupertinoIcons.forward,
                                          color: Colors.orange,
                                        ))
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Divider(color: Colors.black,
                      thickness: .2,
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Container(
                      height: 35,
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Reset Data",
                            style: TextStyle(fontSize: 16, color: Colors.red,),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResetDataPage()));
                              },
                              icon: Icon(
                                CupertinoIcons.forward,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      );
    });
  }
}
