import 'package:flutter/material.dart';
class CurrencyProvider with ChangeNotifier {
  String _currencySymbol = "\$";

  String get currencySymbol => _currencySymbol;

  void setCurrencySymbol(String symbol) {
    _currencySymbol = symbol;
    notifyListeners();
  }
}
