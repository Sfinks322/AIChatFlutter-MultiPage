import 'package:flutter/material.dart';
import '../models/chat.dart';

class HomeProvider extends ChangeNotifier {
  List<Chat> _chats = [];

  List<Chat> get chats => _chats;

  Future<void> loadChats() async {
    _chats = [];
    notifyListeners();
  }

  Future<Chat> createNewChat({String title = 'Новый чат'}) async {
    final chat = Chat(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      messages: [],
    );
    _chats.insert(0, chat);
    notifyListeners();
    return chat;
  }

  Future<void> deleteChat(String chatId) async {
    _chats.removeWhere((chat) => chat.id == chatId);
    notifyListeners();
  }

  Future<void> updateChat(Chat chat) async {
    final index = _chats.indexWhere((c) => c.id == chat.id);
    if (index != -1) {
      _chats[index] = chat;
      notifyListeners();
    }
  }
}