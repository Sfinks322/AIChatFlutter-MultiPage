import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../providers/chat_provider.dart';

class ExpensesChartScreen extends StatefulWidget {
  const ExpensesChartScreen({super.key});

  @override
  State<ExpensesChartScreen> createState() => _ExpensesChartScreenState();
}

class _ExpensesChartScreenState extends State<ExpensesChartScreen> {
  int _selectedPeriod = 7;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('График расходов'),
        centerTitle: true,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          final messages = chatProvider.messages;

          // Собираем расходы по дням
          final Map<String, double> dailyCosts = {};
          double totalCost = 0;

          for (final msg in messages) {
            if (!msg.isUser && msg.cost != null) {
              final dateKey = '${msg.timestamp.year}-${msg.timestamp.month.toString().padLeft(2, '0')}-${msg.timestamp.day.toString().padLeft(2, '0')}';
              dailyCosts[dateKey] = (dailyCosts[dateKey] ?? 0) + msg.cost!;
              totalCost += msg.cost!;
            }
          }

          // Фильтруем по периоду
          final cutoff = DateTime.now().subtract(Duration(days: _selectedPeriod));
          final filteredExpenses = dailyCosts.entries
              .where((e) => DateTime.parse(e.key).isAfter(cutoff))
              .toList()
            ..sort((a, b) => a.key.compareTo(b.key));

          if (filteredExpenses.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart, size: 80,
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text('Нет данных за выбранный период'),
                  const SizedBox(height: 8),
                  const Text('Отправьте сообщения в чате'),
                ],
              ),
            );
          }

          final maxCost = filteredExpenses.map((e) => e.value).reduce((a, b) => a > b ? a : b);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 7, label: Text('7 дней')),
                    ButtonSegment(value: 30, label: Text('30 дней')),
                    ButtonSegment(value: 90, label: Text('90 дней')),
                  ],
                  selected: {_selectedPeriod},
                  onSelectionChanged: (value) {
                    setState(() => _selectedPeriod = value.first);
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: maxCost * 1.2,
                            barGroups: filteredExpenses.asMap().entries.map((entry) {
                              return BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                    toY: entry.value.value,
                                    color: Colors.blue,
                                    width: 16,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ],
                              );
                            }).toList(),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final index = value.toInt();
                                    if (index >= 0 && index < filteredExpenses.length) {
                                      final date = filteredExpenses[index].key;
                                      return Text(date.substring(5), style: const TextStyle(fontSize: 10));
                                    }
                                    return const Text('');
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text('\$${value.toStringAsFixed(2)}', style: const TextStyle(fontSize: 10));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Итого за период: \$${filteredExpenses.fold(0.0, (sum, e) => sum + e.value).toStringAsFixed(4)}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}