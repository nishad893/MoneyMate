import 'package:flutter/material.dart';

// Enum to define time periods
enum TimePeriod { daily, monthly, yearly }

class TimePeriodChanger with ChangeNotifier {
  TimePeriod _selectedPeriod = TimePeriod.daily;

  TimePeriod get selectedPeriod => _selectedPeriod;

  String get selectedPeriodString {
    switch (_selectedPeriod) {
      case TimePeriod.daily:
        return 'Daily';
      case TimePeriod.monthly:
        return 'Monthly';
      case TimePeriod.yearly:
        return 'Yearly';
      default:
        return 'Unknown';
    }
  }

  void setPeriod(TimePeriod period) {
    _selectedPeriod = period;
    notifyListeners();
  }
}
