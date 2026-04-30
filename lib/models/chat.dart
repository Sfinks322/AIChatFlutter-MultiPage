class Chat {
  final String id;
  String title;
  final DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> messages;
  String modelId;
  String provider;

  Chat({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.messages,
    this.modelId = '',
    this.provider = 'openrouter',
  });
}