class TokenUsageStats {
  final String modelName;
  final int totalTokens;
  final int requestCount;
  final double totalCost;

  TokenUsageStats({
    required this.modelName,
    required this.totalTokens,
    required this.requestCount,
    required this.totalCost,
  });
}

class DailyExpense {
  final DateTime date;
  final double totalCost;

  DailyExpense({
    required this.date,
    required this.totalCost,
  });
}