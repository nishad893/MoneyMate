// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// main(){runApp(MaterialApp(home: BudgetModePage(),));}
//
//
// class BudgetModePage extends StatefulWidget {
//   @override
//   _BudgetModePageState createState() => _BudgetModePageState();
// }
//
// class _BudgetModePageState extends State<BudgetModePage> {
//   bool isBudgetModeOn = false;
//   bool includeIncome = false;
//   double budgetAmount = 0.0;
//   double incomeAmount = 0.0;
//   TextEditingController budgetController = TextEditingController();
//
//   void updateBudgetAmount(double income) {
//     setState(() {
//       if (includeIncome) {
//         budgetAmount += income;
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     budgetController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Budget Mode"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Budget Mode",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: Icon(Icons.question_mark),
//                     onPressed: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text("Info"),
//                             content: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "Budget Mode allows you to track your spending against a fixed budget amount. For example, you could set a spending limit of 500 per month:\n\n"
//                                       "Budget Mode:\n"
//                                       "Turn this on if you want to track how much money you have left to spend based on a fixed budget.\n\n"
//                                       "Budget Amount:\n"
//                                       "Set your budget. If you choose to track your spending monthly by default, then this will be your monthly budget and so on.\n\n"
//                                       "Include Income:\n"
//                                       "Turn this on if you want any income transactions to increase your budget for the time period.",
//                                 ),
//                               ],
//                             ),
//                             actions: [
//                               TextButton(
//                                 child: Text("OK"),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Divider(),
//             Row(
//               children: [
//                 Text(
//                   "Budget Mode",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Spacer(),
//                 Switch(
//                   value: isBudgetModeOn,
//                   onChanged: (value) {
//                     setState(() {
//                       isBudgetModeOn = value;
//                     });
//                   },
//                   activeColor: Colors.orange,
//                   inactiveTrackColor: Colors.grey,
//                 ),
//               ],
//             ),
//             if (isBudgetModeOn) ...[
//               SizedBox(height: 20),
//               TextField(
//                 controller: budgetController,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(
//                   labelText: "Budget Amount",
//                   hintText: "Enter a Amount",
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     budgetAmount = double.tryParse(value) ?? 0.0;
//                   });
//                 },
//               ),
//               SizedBox(height: 20),
//               Row(
//                 children: [
//                   Text(
//                     "Include Income",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   Spacer(),
//                   Switch(
//                     value: includeIncome,
//                     onChanged: (value) {
//                       setState(() {
//                         includeIncome = value;
//                         if (includeIncome) {
//                           budgetAmount += incomeAmount;
//                         } else {
//                           budgetAmount -= incomeAmount;
//                         }
//                         budgetController.text = budgetAmount.toString();
//                       });
//                     },
//                     activeColor: Colors.orange,
//                     inactiveTrackColor: Colors.grey,
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(home: BudgetModePage()));
}

class BudgetModePage extends StatefulWidget {
  @override
  _BudgetModePageState createState() => _BudgetModePageState();
}

class _BudgetModePageState extends State<BudgetModePage> {
  bool isBudgetModeOn = false;
  bool includeIncome = false;
  double budgetAmount = 0.0;
  double incomeAmount = 0.0;
  TextEditingController budgetController = TextEditingController();

  void updateBudgetAmount(double income) {
    setState(() {
      if (includeIncome) {
        budgetAmount += income;
      }
    });
  }

  Future<void> saveDataToFirestore() async {
    CollectionReference budgetData = FirebaseFirestore.instance.collection('budgetData');

    await budgetData.add({
      'isBudgetModeOn': isBudgetModeOn,
      'includeIncome': includeIncome,
      'budgetAmount': budgetAmount,
      'incomeAmount': incomeAmount,
    });

    Navigator.pop(context);
  }

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Mode"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, budgetAmount.toString());
          },
        ),
        actions: [
          TextButton(
            onPressed: saveDataToFirestore,
            child: Text(
              "Done",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Budget Mode",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.question_mark),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Info"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Budget Mode allows you to track your spending against a fixed budget amount. For example, you could set a spending limit of 500 per month:\n\n"
                                      "Budget Mode:\n"
                                      "Turn this on if you want to track how much money you have left to spend based on a fixed budget.\n\n"
                                      "Budget Amount:\n"
                                      "Set your budget. If you choose to track your spending monthly by default, then this will be your monthly budget and so on.\n\n"
                                      "Include Income:\n"
                                      "Turn this on if you want any income transactions to increase your budget for the time period.",
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Text(
                  "Budget Mode",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Switch(
                  value: isBudgetModeOn,
                  onChanged: (value) {
                    setState(() {
                      isBudgetModeOn = value;
                    });
                  },
                  activeColor: Colors.orange,
                  inactiveTrackColor: Colors.grey,
                ),
              ],
            ),
            if (isBudgetModeOn) ...[
              SizedBox(height: 20),
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Budget Amount",
                  hintText: "Enter a Amount",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    budgetAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Include Income",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Switch(
                    value: includeIncome,
                    onChanged: (value) {
                      setState(() {
                        includeIncome = value;
                        if (includeIncome) {
                          budgetAmount += incomeAmount;
                        } else {
                          budgetAmount -= incomeAmount;
                        }
                        budgetController.text = budgetAmount.toString();
                      });
                    },
                    activeColor: Colors.orange,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
