
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_switch/sliding_switch.dart';
void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SettingsPage(),
  ));
}

class SettingsPage extends StatefulWidget {

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  TextEditingController _currency = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;


          return
              Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey[850],
                  title: Center(
                    child: Text("Settings",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,

                    ),),
                  ),

                ),

      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                alignment: Alignment.centerLeft,
                height: 205,
                width: double.infinity,
                color: Colors.grey[850],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey[800],
                        width: double.infinity,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Spending",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                "Time Period",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 195,
                              ),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  height: 28,
                                  width: 67,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      "Monthly",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey),
                                    ),
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 253,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                              )
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 272,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                              )
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 175,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
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
                color: Colors.grey[850],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey[800],
                        width: double.infinity,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Account Management",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 280,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
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
                height: 59,
                width: double.infinity,
                color: Colors.grey[850],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey[800],
                        width: double.infinity,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Automatic Syncing",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                "Dropbox sync",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 250,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
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
                height: 10 ,
              ),
              Container(
                alignment: Alignment.centerLeft,
                height: 245,
                width: double.infinity,
                color: Colors.grey[850],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey[800],
                        width: double.infinity,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "User Iterface",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 270,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                              )
                            ],
                          ),
                        )),
                    Divider(
                      thickness: .2,
                    ),
                    Container(
                        width: double.infinity,
                        height: 35,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:Row(

                            children: [
                              Container(
                                height: 30,
                                width: 100,
                                child: Text("Currency",style: TextStyle(fontSize: 16,color: Colors.blueGrey),),
                              ),
                              SizedBox(width: 260,),

                              Container(
                                height: 30,
                                width: 30,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white,fontSize: 25),
                                  controller: _currency,

                                  decoration: InputDecoration(
                                    hintText: "",
                                    hintStyle: TextStyle(fontSize: 16,color: Colors.blueGrey)
                                  )
                                  ,
                                  onTap: (){
                                    showCurrencyPicker(
                                      context: context,
                                      onSelect:(Currency currency){
                                        setState(() {
                                          _currency.text = currency.symbol;

                                        });
                                      },
                                      theme: CurrencyPickerThemeData(
                                        flagSize: 25,
                                        titleTextStyle:  TextStyle(fontSize: 18),

                                      ),
                                      showFlag: true,
                                      showSearchField: true,
                                      showCurrencyName: true,
                                      showCurrencyCode: true,
                                      favorite: ['eur'],

                                    );
                                  },

                                ),
                              ),
                            ],
                          )
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 180,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                              )
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(width: 200),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Chalk",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )),
                    Divider(
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
                                "Category Icon Style",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(width: 165),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Filled",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
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
                height: 245,
                width: double.infinity,
                color: Colors.grey[850],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey[800],
                        width: double.infinity,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Genaral",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(width: 145),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Not Upgraded",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(width: 230),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "daily",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 250,
                              ),

                              // Text("Off",style: TextStyle(fontSize: 18,color: Colors.white70),),
                              // IconButton(onPressed: (){}, icon:Icon(CupertinoIcons.forward,color: Colors.grey,))
                              SlidingSwitch(
                                background: Colors.grey,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
                                },
                                onTap: () {},
                                onDoubleTap: () {},
                                onSwipe: () {},
                              )
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 280,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )),
                    Divider(
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 270,
                              ),
                              SlidingSwitch(
                                background: Colors.grey,
                                colorOff: Colors.red,
                                colorOn: Colors.green,
                                textOff: "",
                                textOn: "",
                                value: false,
                                width: 50,
                                onChanged: (bool value) {
                                  print(value);
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
                color: Colors.grey[850],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        color: Colors.grey[800],
                        width: double.infinity,
                        height: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "About",
                            style: TextStyle(color: Colors.white, fontSize: 16),
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
                                    color: Colors.blueGrey, fontSize: 16),
                              ),
                              SizedBox(
                                width: 250,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                        )),
                    Divider(
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
                                      color: Colors.blueGrey, fontSize: 16)),
                              SizedBox(
                                width: 225,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.forward,
                                    color: Colors.grey,
                                  ))
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
                height: 35,
                width: double.infinity,
                color: Colors.grey[850],
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Reset Data",
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                    SizedBox(
                      width: 250,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          CupertinoIcons.forward,
                          color: Colors.grey,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
              );
    }
  }