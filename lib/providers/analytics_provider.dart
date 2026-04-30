import 'package:flutter/material.dart';
import '../models/token_stats.dart';
import '../services/analytics_service.dart';

class AnalyticsProvider extends ChangeNotifier {
  List<TokenUsageStats> _tokenStats = [];
  List<DailyExpense> _dailyExpenses = [];
  double _totalSpent = 0;
  int _totalTokens = 0;
  bool _isLoading = false;

  List<TokenUsageStats> get tokenStats => _tokenStats;
  List<DailyExpense> get dailyExpenses => _dailyExpenses;
  double get totalSpent => _totalSpent;
  int get totalTokens => _totalTokens;
  bool get isLoading => _isLoading;

  Future<void> loadAnalytics() async {
    _isLoading = true;
    notifyListeners();

    // Заглушка — потом подключим аналитику
    _tokenStats = [];
    _dailyExpenses = [];
    _totalSpent = 0;
    _totalTokens = 0;

    _isLoading = false;
    notifyListeners();
  }

  List<DailyExpense> getExpensesForLastDays(int days) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return _dailyExpenses.where((day) => day.date.isAfter(cutoff)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}