import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика токенов'),
        centerTitle: true,
      ),
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          final messages = chatProvider.messages;
          
          if (messages.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Нет данных для отображения'),
                  SizedBox(height: 8),
                  Text('Отправьте сообщение в чате, затем вернитесь сюда'),
                ],
              ),
            );
          }

          final modelStats = <String, Map<String, dynamic>>{};
          int totalTokens = 0;
          double totalCost = 0;

          for (final msg in messages) {
            if (!msg.isUser && msg.modelId != null) {
              final model = msg.modelId!;
              modelStats.putIfAbsent(model, () => {'count': 0, 'tokens': 0, 'cost': 0.0});
              modelStats[model]!['count']++;
              if (msg.tokens != null) {
                modelStats[model]!['tokens'] += msg.tokens!;
                totalTokens += msg.tokens!;
              }
              if (msg.cost != null) {
                modelStats[model]!['cost'] += msg.cost!;
                totalCost += msg.cost!;
              }
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Всего токенов',
                        value: _formatNumber(totalTokens),
                        icon: Icons.token,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: 'Потрачено',
                        value: '\$${totalCost.toStringAsFixed(4)}',
                        icon: Icons.attach_money,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (modelStats.isNotEmpty) ...[
                  Text('Использование по моделям',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...modelStats.entries.map((entry) => ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.model_training)),
                    title: Text(entry.key),
                    subtitle: Text('${entry.value['count']} ответов'),
                    trailing: Text('${_formatNumber(entry.value['tokens'])} токенов',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  )),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) return '${(number / 1000000).toStringAsFixed(1)}M';
    if (number >= 1000) return '${(number / 1000).toStringAsFixed(1)}K';
    return number.toString();
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}