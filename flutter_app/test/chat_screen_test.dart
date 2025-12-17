import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_app/screens/chat_screen.dart';

import 'fakes/fake_chat_storage.dart';

void main() {
  testWidgets('sending a message shows it in the list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatScreen(enableAutoReply: false, storage: FakeChatStorage()),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('chat_input')), 'Hello');
    await tester.tap(find.byKey(const Key('chat_send')));
    await tester.pump();

    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('auto-reply appears after 1 second (deterministic)', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChatScreen(
            storage: FakeChatStorage(),
            autoReplies: const ['OK'],
            random: Random(0),
          ),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('chat_input')), 'Ping');
    await tester.tap(find.byKey(const Key('chat_send')));
    await tester.pump(); // outgoing message rendered

    // advance fake time for Timer
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.text('OK'), findsOneWidget);
  });
}
