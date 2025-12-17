import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/message.dart';

abstract class ChatStorage {
  Future<List<Message>> load();
  Future<void> save(List<Message> messages);
  Future<void> clear();
}

class SharedPrefsChatStorage implements ChatStorage {
  SharedPrefsChatStorage({this.keyName = 'chat_messages_v1'});

  final String keyName;

  @override
  Future<List<Message>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(keyName);
    if (raw == null) return [];

    final List decoded = jsonDecode(raw) as List;
    return decoded
        .map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> save(List<Message> messages) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(messages.map((m) => m.toJson()).toList());
    await prefs.setString(keyName, encoded);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyName);
  }
}
