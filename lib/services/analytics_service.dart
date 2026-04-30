import 'package:flutter/foundation.dart';

class AnalyticsService {
  final List<Map<String, dynamic>> _sessions = [];
  final Map<String, Map<String, dynamic>> _modelStats = {};

  void trackMessage({
    required String model,
    required int messageLength,
    required double responseTime,
    required int tokensUsed,
  }) {
    final session = {
      'model': model,
      'messageLength': messageLength,
      'responseTime': responseTime,
      'tokensUsed': tokensUsed,
      'date': DateTime.now().toIso8601String(),
      'cost': _calculateCost(model, tokensUsed),
    };
    _sessions.add(session);

    if (!_modelStats.containsKey(model)) {
      _modelStats[model] = {
        'count': 0,
        'tokens': 0,
        'cost': 0.0,
        'totalResponseTime': 0.0,
      };
    }
    _modelStats[model]!['count'] = (_modelStats[model]!['count'] as int) + 1;
    _modelStats[model]!['tokens'] = (_modelStats[model]!['tokens'] as int) + tokensUsed;
    _modelStats[model]!['cost'] = (_modelStats[model]!['cost'] as double) + (_calculateCost(model, tokensUsed));
    _modelStats[model]!['totalResponseTime'] = (_modelStats[model]!['totalResponseTime'] as double) + responseTime;
  }

  double _calculateCost(String model, int tokens) {
    return tokens * 0.000001;
  }

  Map<String, dynamic> getStatistics() {
    return {
      'total_sessions': _sessions.length,
      'model_stats': _modelStats,
    };
  }

  Map<String, dynamic> exportSessionData() {
    return {
      'sessions': _sessions,
    };
  }

  Map<String, Map<String, double>> getModelEfficiency() {
    final efficiency = <String, Map<String, double>>{};
    for (final entry in _modelStats.entries) {
      final avgResponseTime = (entry.value['totalResponseTime'] as double) / (entry.value['count'] as int);
      efficiency[entry.key] = {
        'avgResponseTime': avgResponseTime,
        'totalCost': entry.value['cost'] as double,
      };
    }
    return efficiency;
  }

  Map<String, double> getResponseTimeStats() {
    if (_sessions.isEmpty) return {'avg': 0, 'min': 0, 'max': 0};
    final times = _sessions.map((s) => s['responseTime'] as double).toList();
    times.sort();
    return {
      'avg': times.reduce((a, b) => a + b) / times.length,
      'min': times.first,
      'max': times.last,
    };
  }

  Map<String, int> getMessageLengthStats() {
    if (_sessions.isEmpty) return {'avg': 0, 'min': 0, 'max': 0};
    final lengths = _sessions.map((s) => s['messageLength'] as int).toList();
    lengths.sort();
    return {
      'avg': lengths.reduce((a, b) => a + b) ~/ lengths.length,
      'min': lengths.first,
      'max': lengths.last,
    };
  }

  void clearData() {
    _sessions.clear();
    _modelStats.clear();
  }
}