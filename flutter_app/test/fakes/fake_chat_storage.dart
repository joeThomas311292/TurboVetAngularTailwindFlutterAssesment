import 'package:flutter_app/models/message.dart';
import 'package:flutter_app/storage/chat_storage.dart';

class FakeChatStorage implements ChatStorage {
  List<Message> _data = [];

  @override
  Future<void> clear() async {
    _data = [];
  }

  @override
  Future<List<Message>> load() async {
    return List.of(_data);
  }

  @override
  Future<void> save(List<Message> messages) async {
    _data = List.of(messages);
  }
}
